**Note:** This project is under active development 🚧 Changes happen rapidly and without backwards compatibility.

# Isabelle/Set [![Build Status](https://github.com/kappelmann/Isabelle-Set/actions/workflows/build.yml/badge.svg)](https://github.com/kappelmann/Isabelle-Set/actions)

Isabelle/Set is a mathematical environment that aims to combine the flexibility of set theory and expressiveness of type theory.
As a mathematical foundation, it is based on higher-order Tarski-Grothendieck set theory.
On top of this, it adds an optional layer of soft types inside the object logic.

A soft type can simply be thought as a predicate verifying certain properties about the mathematical entity in question.
These predicates can be arbitrarily complex, allowing simple assertions such as an entity being a member of a certain set (e.g. "n : Nat")
all the way to dependently typed assertions such as "zero\_vector : (n : Nat) -> Vector n".

Soft types are not unique: an entity can belong to many different soft types.
As an example, both "1 : Nat" and "1 : Int" are valid soft type assertions.
This is in contrast to conventional type-theoretical environments where each term belongs to a unique, unalterable type.
Those systems have to insert explicit casts to transform terms from one type to another.

## How to Build / Run

This code depends on:
1. The [Isabelle repository](https://isabelle.in.tum.de/repos/isabelle):
   The file `ISABELLE_VERSION` specifies the exact mecurial revision,
   which will also be used in the automated builds.
2. The [AFP mirror repository](https://github.com/isabelle-prover/mirror-afp-devel/):
   The file `AFP_VERSION` specifies the exact git revision,
   which will also be used in the automated builds.

Instructions:
1. Clone and prepare the correct Isabelle development version.
   Instructions can be found in the
   [README\_REPOSITORY](https://isabelle.in.tum.de/repos/isabelle/file/tip/README_REPOSITORY).
2. Clone and add the correct AFP version.
   Instructions can be found on the
   [AFP-website](https://www.isa-afp.org/using.html).
3. Clone and navigate into this repository:
  ```bash
  git clone --recurse-submodules git@github.com:kappelmann/Isabelle-Set.git
  cd Isabelle_Set
  ```
4. Build the supporting Isabelle heap images:
  ```bash
  /<path_to_isabelle>/bin/isabelle build -vbRD .
  ```
5. Build this development:
  ```
  /<path_to_isabelle>/bin/isabelle build -vD .
  ```
6. Open the development:
  ```
  /<path_to_isabelle>/bin/isabelle jedit -l HOL -d .
  ```

## Style Guide

As a continuous effort, we make use of and iterate on the recently developed
[Isabelle Community Conventions](https://isabelle.systems/conventions/)

## Entry points

The development is in a very experimental state.
Here are some good entry points for reading the sources:

File | Content
-----|--------
`HOTG/Axioms` | Axiomatisation of Tarski-Grothendieck set theory embedded in higher-order logic (HOTG).
`HOTG/*` | Basic set-theoretic results using HOTG.
`Soft_Types/Soft_Types_HOL.thy` | Notion of soft type (based on HOL), types as predicates, function types, intersection types, etc.
`Soft_Types/*.ML` | Infrastructure for soft types: elaboration, unification, context data, etc.
`Soft_Types/Tests/Elaboration_Tests.thy` | Some examples of how soft type elaboration works, but mostly in the form of test cases.
`Soft_Types/Tests/Implicit_Arguments_Tests.thy` | Demonstrates automatic insertion of implicit arguments
`Soft_Types/Tests/Isar_Integration_tests.thy` | Demonstrates automatic generation of typing assumptions in proof contexts.
`Isabelle_Set/{Sets,Binary_Relations,Function,Fixpoints}.thy` | Further set-theoretic concepts with soft types
`Isabelle_Set/Structures.thy` | Basic syntax for structures
`Isabelle_Set/Set_Extension.thy` | Definitional set extension principle
`Isabelle_Set/Integer.thy` | Application of the set extension principle to construct `ℤ ⊇ ℕ`

## Automated builds

Automated builds can be found [here](https://github.com/kappelmann/Isabelle-Set/actions).
There you can also configure email notifications for failed builds.

## Contact

The project is currently developed by [Kevin Kappelmann](https://www21.in.tum.de/~kappelmk/)
and was initiated by [Alex Krauss](https://www21.in.tum.de/~krauss/) and [Josh Chen](https://joshchen.io/).

You can contact Kevin on the [Isabelle Zulip](https://isabelle.zulipchat.com/) or by [e-mail](kevin.kappelmann@tum.de).
