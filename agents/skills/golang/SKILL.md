---
name: golang
description: Idiomatic Go conventions and tooling - gofmt/goimports, go vet, golangci-lint, table-driven tests, and the cmd/internal/pkg layout. Use when writing, reviewing, scaffolding, or refactoring Go code for services or CLIs. Encodes error handling, interfaces, concurrency, testing, naming, and the anti-patterns to avoid. Distilled from Effective Go, Google's Go style guide, and the Uber Go style guide.
---

# Go Conventions

Idiomatic Go for services and CLIs. The toolchain is fixed: `go build/vet/test`,
`gofmt`/`goimports` (non-negotiable), **golangci-lint**, and **table-driven tests**.

## Project layout

```
myapp/
├── cmd/<appname>/main.go   # thin entrypoint: wire flags/config, call into internal
├── internal/               # all app logic (compiler-enforced privacy) - default here
├── pkg/                    # ONLY code intended for external reuse
└── go.mod
```

- `main.go` is thin: parse flags/config, then call a `run() error`; `main` is the one
  place that calls `os.Exit`/`log.Fatal`.
- Default everything to `internal/`; use `pkg/` only when you truly want external import.
- Libraries take config as parameters - never read flags/env directly (testability).
- Avoid `util`/`common`/`helper` package names; name packages by what they provide.
- No `init()` unless deterministic, no I/O, no cross-`init` ordering dependence.

## Errors

- Exported funcs return the `error` interface, never a concrete error type (nil-pointer-
  in-interface bug).
- Error strings: lowercase, no trailing punctuation.
- Wrap to preserve the chain: `fmt.Errorf("doing x: %w", err)` (use `%w` for
  `errors.Is`/`errors.As`; use `%v` at system/API boundaries to avoid leaking internals).
- Sentinel errors (`var ErrNotFound = errors.New(...)`) when callers need `errors.Is`;
  typed errors when callers need data via `errors.As`.
- Handle each error deliberately; handle once (log OR return, not both). Never `_ = err`
  without a comment.
- No `panic` in libraries - panic is for programmer errors only.
- Aggregate concurrent errors with `golang.org/x/sync/errgroup`.

## Interfaces

- Accept interfaces, return concrete/struct types.
- Interfaces belong in the **consuming** package, not the implementer's. Don't predefine
  an interface with no caller (YAGNI).
- Keep them small and single-method where possible; name `<Verb>er` (Reader, Writer).
- Pointer receivers by default; don't mix value/pointer receivers on one type.
- Compile-time check when useful: `var _ io.Reader = (*Foo)(nil)`.

## Concurrency

- "Share memory by communicating." Prefer synchronous functions - let the caller add
  concurrency; don't spawn goroutines inside libraries unexpectedly.
- Every goroutine needs a defined exit path; use `context.Context` for cancellation.
- Channels: specify direction (`chan<-`, `<-chan`); buffer 0 or 1 unless justified.
- `sync.Mutex`/`RWMutex` for shared state; channels for ownership transfer; typed
  atomics (`atomic.Bool`, `atomic.Int64`).
- `errgroup.WithContext` for fan-out with shared cancellation. Consider `goleak` in tests.

## Testing

- Table-driven with `t.Run(tt.name, ...)` subtests for any multi-case logic.
- Self-diagnosing failures: `Func(%v) = %v, want %v`.
- Compare structures with `cmp.Diff` (`(-want +got)`); avoid assertion libraries.
- `t.Error` by default (collect failures); `t.Fatal` only when continuing is pointless,
  never from a non-test goroutine.
- Helpers call `t.Helper()`; teardown via `t.Cleanup()`, not `defer`.
- Assert error semantics with `errors.Is`/`errors.As`, never string-matching messages.
- Run with `-race`.

## Linting (.golangci.yml baseline)

Enable at least: `errcheck`, `govet`, `staticcheck`, `revive`, `goimports`,
`ineffassign`, `misspell`; add `gosec`, `bodyclose` for services. Pin the
golangci-lint version in CI. Use `//nolint:<linter> // reason` - never a bare `//nolint`.
(Adjust syntax to your golangci-lint major version.)

## Anti-patterns to avoid

- In-band error signaling (`-1`, `nil`, `""` for "not found") instead of `(T, bool)`/`(T, error)`
- Deep nesting instead of guard-clause early returns
- `Get`-prefixed getters (`Name()`, not `GetName()`)
- Stuttering names (`widget.NewWidget`)
- Mixed receiver types; `os.Exit`/`log.Fatal` outside `main()`
- Global mutable state; non-deterministic `init()`

## Definition of done

`gofmt -l` empty, `go vet ./...` clean, `golangci-lint run` clean,
`go test ./... -race` green.
