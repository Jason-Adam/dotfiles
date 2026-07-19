/**
 * format-on-edit -- Pi extension that auto-formats Python and Go files
 * after every edit or write tool call.
 *
 *   .py  -> ruff format + ruff check --fix
 *   .go  -> gofmt -w
 *
 * Install: symlink to ~/.pi/agent/extensions/format-on-edit.ts
 */

import { extname, resolve } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	pi.on("tool_result", async (event, ctx) => {
		// Only run on successful edit/write calls
		if (event.isError) return;
		if (event.toolName !== "edit" && event.toolName !== "write") return;

		const rawPath = event.input.path as string | undefined;
		if (!rawPath) return;

		const filePath = resolve(ctx.cwd, rawPath);
		const ext = extname(filePath);

		if (ext !== ".py" && ext !== ".go") return;

		const notes: string[] = [];

		if (ext === ".py") {
			// ruff format (in-place)
			try {
				const r = await pi.exec("ruff", ["format", filePath], {
					cwd: ctx.cwd,
					timeout: 15_000,
				});
				const line = r.stdout.trim();
				if (line) notes.push(`ruff format: ${line}`);
			} catch (e: any) {
				const msg = e.stderr?.trim() || e.message;
				if (!ignorableExecError(msg))
					notes.push(`ruff format: ${msg}`);
			}

			// ruff check --fix (lint auto-fix)
			try {
				const r = await pi.exec("ruff", ["check", "--fix", filePath], {
					cwd: ctx.cwd,
					timeout: 15_000,
				});
				const line = r.stdout.trim();
				if (line) notes.push(`ruff check: ${line}`);
			} catch (e: any) {
				const msg = e.stderr?.trim() || e.message;
				if (!ignorableExecError(msg))
					notes.push(`ruff check: ${msg}`);
			}
		} else if (ext === ".go") {
			try {
				const r = await pi.exec("gofmt", ["-w", filePath], {
					cwd: ctx.cwd,
					timeout: 15_000,
				});
				const line = r.stdout.trim();
				if (line) notes.push(`gofmt: ${line}`);
			} catch (e: any) {
				const msg = e.stderr?.trim() || e.message;
				if (!ignorableExecError(msg))
					notes.push(`gofmt: ${msg}`);
			}
		}

		if (notes.length > 0) {
			return {
				content: [
					...event.content,
					{
						type: "text" as const,
						text: `\n[format-on-edit]\n${notes.join("\n")}`,
					},
				],
			};
		}
	});
}

/** True for errors we silently absorb (binary not found, file gone mid-run). */
function ignorableExecError(msg: string): boolean {
	return (
		msg.includes("No such file or directory") ||
		msg.includes("command not found") ||
		msg.includes("ENOENT")
	);
}
