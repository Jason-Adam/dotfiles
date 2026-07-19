---
name: python
description: Idiomatic modern Python (3.12+) conventions and tooling - src/ layout, uv for deps/venv, ruff for lint+format, strict mypy, and pytest. Use when writing, reviewing, scaffolding, or refactoring Python code, or setting up a Python project's tooling. Encodes typing, error handling, testing, data modeling, and async conventions plus the anti-patterns to avoid.
---

# Python Conventions

Idiomatic, production-grade Python for 3.12+. Full type hints everywhere, `src/`
layout, and a single `pyproject.toml`. The toolchain is fixed: **uv** (deps/venv),
**ruff** (lint + format), **mypy** (strict typing), **pytest** (tests).

## Project layout

```
my-package/
├── pyproject.toml          # single source of config
├── uv.lock                 # lockfile (committed)
├── README.md
├── src/
│   └── my_package/
│       ├── __init__.py
│       └── module.py
└── tests/
    └── test_module.py
```

`src/` layout always - it prevents accidental `import`-from-cwd and forces
install-based testing. Never hack `sys.path`.

## pyproject.toml (canonical)

```toml
[project]
name = "my-package"
requires-python = ">=3.12"
dependencies = []

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[dependency-groups]
dev = ["pytest", "pytest-cov", "ruff", "mypy"]

[tool.ruff]
target-version = "py312"
line-length = 100
[tool.ruff.lint]
select = ["E", "F", "I", "UP", "B", "SIM", "RUF"]

[tool.mypy]
python_version = "3.12"
strict = true

[tool.pytest.ini_options]
testpaths = ["tests"]
```

## Tooling commands

```bash
uv init .                       # scaffold
uv add <pkg>                    # runtime dep
uv add --dev pytest ruff mypy   # dev deps
uv sync                         # install from lock
uv run ruff check --fix .       # lint (autofix)
uv run ruff format .            # format
uv run mypy src                 # typecheck
uv run pytest                   # test
```

Always go through `uv run ...`; never `pip install` into a uv project and never
activate venvs manually.

## Typing (mypy strict)

- Annotate every function signature (params + return, including `-> None`) and every
  class attribute. No untyped defs.
- Modern syntax: `X | None` (not `Optional[X]`), built-in generics (`list[int]`,
  `dict[str, K]`), `type X = ...` aliases (3.12).
- Prefer `typing.Protocol` (structural) over ABCs for interfaces.
- Avoid `Any`; if unavoidable, isolate and comment why.

## Error handling

- Define a small domain exception hierarchy (`class ConfigError(Exception): ...`);
  never raise or catch bare `Exception`.
- Fail fast with actionable messages. Preserve chains: `raise ConfigError(...) from err`.
- Never `except: pass` or log-and-continue without a deliberate reason.

## Testing (pytest)

- AAA structure (Arrange / Act / Assert); one behavior per test.
- Name `test_<unit>_<scenario>_<expected>`.
- `@pytest.mark.parametrize` instead of loops or duplicated test bodies.
- Fixtures in `conftest.py`, smallest scope that works (`function` default).
- Assert exceptions with `pytest.raises(SpecificError)` - never broad.
- Mock only at boundaries (network, filesystem, clock via `time-machine`); never mock
  the unit under test. Test behavior, not implementation.
- Coverage (`pytest --cov`) is a signal, not a target.
- Prefer test-first (see the `tdd` skill) for new behavior and bug fixes.

## Data modeling

- `@dataclass(frozen=True, slots=True)` for internal value objects / DTOs - prefer
  immutability by default.
- Pydantic `BaseModel` only at real validation boundaries (API/CLI input, config,
  external data). Don't pull pydantic into pure internal code.

## Async

- `asyncio` for I/O-bound concurrency only; use `concurrent.futures`/`multiprocessing`
  for CPU-bound work.
- Structured concurrency: `asyncio.TaskGroup` (3.11+) over loose `gather`. Always
  propagate cancellation; never swallow `CancelledError`.
- Don't call blocking code inside `async def` without `asyncio.to_thread`.

## Anti-patterns to avoid

- Mutable default arguments (`def f(x=[])`)
- Broad/bare `except` hiding bugs
- Global mutable state; impure functions where purity is cheap
- `from x import *`
- `sys.path` manipulation instead of proper `src/` packaging
- Skipping type hints "because it's just a script"

## Definition of done

Run `py-check` - it runs ruff (lint + format check), mypy, and pytest, and fails if
any gate fails. All must pass before the work is done.
