---
name: hexagonal-architecture
description: Language-agnostic ports-and-adapters (hexagonal) architecture guidance for designing and maintaining a service - the domain/application core, ports, driving/driven adapters, the dependency rule, testing seams, and incremental (strangler) migration. Use when structuring a new service, adding a use case/port/adapter, keeping business logic free of I/O, or refactoring a tangled service toward clean boundaries. For auditing a diff against these rules, use the hexagonal-architecture-reviewer subagent.
---

# Hexagonal Architecture (Ports & Adapters)

Keep business logic pure and isolated from I/O. The app must be runnable and testable
with no real UI and no real database. Concepts (Cockburn's ports-and-adapters; the same
core underlies Clean and Onion architecture - only the vocabulary differs).

## The model

- **Domain / application core** (the inside): entities, value objects, and use cases /
  application services. Pure logic. Knows nothing about the outside.
- **Ports**: interfaces owned by the core that describe a conversation with the outside.
  - **Driving / primary ports**: how the outside calls in (a use-case interface).
  - **Driven / secondary ports**: what the core needs from the outside (a repository,
    a clock, a payment gateway), defined as an interface *in the core*.
- **Adapters**: implementations that translate between a port and a real technology.
  - **Driving / primary adapters**: HTTP handler, CLI, test harness, message consumer.
  - **Driven / secondary adapters**: Postgres repo, HTTP client, in-memory fake.
- **Composition root**: one place that instantiates concrete adapters and injects them.

## The one rule

**Dependencies point inward.** Imports/compile-time references flow toward the domain;
the core defines interfaces, outer layers implement them; nothing inside knows the
outside exists. This is the Dependency Inversion Principle applied structurally.

Litmus test: swap the DB for an in-memory fake and the HTTP handler for a test, and the
core still runs unchanged.

## Structure (illustrative, language-agnostic)

```
domain/            # entities, value objects - zero I/O, zero framework imports
application/       # use cases; defines the driven ports (interfaces)
  ports/           # interfaces the core requires (Repository, Clock, Notifier, ...)
adapters/
  inbound/         # http/, cli/, grpc/  (driving)
  outbound/        # postgres/, httpclient/, memory/  (driven)
main/ (or cmd/)    # composition root: build adapters, inject, start
```

## Building each layer

1. **Model the domain** - entities and invariants first, no persistence concerns.
2. **Define driven ports** in the core for what a use case needs (e.g. `OrderRepository`).
3. **Write the use case** as pure orchestration against ports - all business rules live here.
4. **Implement adapters** for each port; adapters only translate (map external shapes
   to/from domain types) - they hold no business logic.
5. **Wire in the composition root** - the only place that knows concrete adapters.

## Testing seams

- **Domain**: pure unit tests, no mocks, no I/O.
- **Use cases**: unit tests with in-memory fake adapters implementing the ports - no DB,
  no network, no Docker.
- **Adapters**: integration tests against the real technology (these alone touch infra).
- **End-to-end**: few, covering critical flows only.

## Pitfalls to avoid

- Domain/application code importing a framework, ORM, HTTP client, or SDK.
- Business rules (validation, calculations, state transitions) living in an adapter.
- Ports defined inside an adapter package instead of the core (ownership inversion).
- Adapters calling other adapters directly, bypassing the core.
- Instantiating a concrete dependency inside a use case instead of injecting it.
- Leaking a DB row / ORM model outward unmapped instead of returning a domain type.

## Incremental migration (strangler fig)

For an existing tangled service, don't rewrite. Extract one vertical slice at a time:
identify a use case, define its ports, pull the business logic into a pure core,
wrap the existing DB/HTTP code as adapters behind those ports, and add an
architecture test (import-linter / dependency-cruiser / ArchUnit / a custom check)
that fails if `domain` imports `adapters`. Repeat slice by slice.
