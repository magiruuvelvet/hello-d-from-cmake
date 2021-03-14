# Hello D from CMake

Simple test to use CMake with D.

~~**Dependencies**:~~

 - ~~https://github.com/magiruuvelvet/gentoo-overlay/tree/master/dev-util/cmake-d (package for https://github.com/dcarp/cmake-d)~~


~~In real world applications those CMake files should be added to the project source though,~~
~~because nobody is gonna install those modules globally on their system.~~

Superseded using CMake module magic, It worked on my machine even after uninstalling the modules from the system.

# What is this repo?

```d
/**
 * Decided to learn D. No plans yet to use it for an application.
 * In this example I try to figure out how D manages memory by
 * reading the docs and getting my hands dirty with some tests,
 * and compare it to the C++ RAII.
 *
 * Also experimenting with C and C++ interoperability by directly
 * linking the foreign language objects into the same binary.
 * No plans to try dynamic loading yet.
 *
 * I know D has a package manager, but I like CMake and git submodules :)
 * If I ever do a real D project, don't expect that I use dub for this.
 */
```

## My comparisons of what I figured out so far

I made this table mainly for myself as cheat sheet.

|                              |   C++                            | D                                |
|------------------------------|----------------------------------|----------------------------------|
| Entry Point                  | `int main(...)`                  | `int main(...)` or `void main()` |
| Multi-paradigm               | Yes                              | Yes                              |
| Runtime Reflections          | No                               | No`??`                           |
| Preprocessor                 | Yes                              | No, but has `version()` for compile-time environmental checks |
| Preprocessor Macros          | Yes, pass in custom values at build time using `-DMYVALUE=123` | `??` (I really hope D can do that, plausible workaround: CMake `configure_file`) |
| Memory Management            | RAII / Smart Pointer             | Garbage Collector / RAII         |
| Scopes                       | Yes                              | Yes                              |
| Function Overloading         | Yes                              | Yes                              |
| Operator Overloading         | Yes, uses operators              | Yes, uses named functions        |
| Abstract Classes             | Yes, `method() = 0`              | Yes, `abstract class`            |
| `final` class                | Yes, `class Name final`          | Yes, `final class Name`          |
| Interfaces                   | No, use abstract classes         | Yes                              |
| Polymorphism                 | Yes                              | Yes                              |
| OOP: `override`              | Yes, after method name           | Yes, before return type          |
| virtual and abstract methods | Yes                              | Yes                              |
| Constructor Name             | Equals class name                | `this()`                         |
| Destructors                  | Yes, `~ClassName()`              | Yes, `~this()`                   |
| Destructor automatically called when out of scope? | Yes        | Yes and No`??` (Garbage Collector) |
| Delete default constructor   | Yes, `ClassName() = delete`      | Yes, `@disable this()`           |
| Templates                    | Yes                              | Yes                              |
| Templates with variadic args | Yes                              | Yes                              |
| Variadic args                | Yes                              | Yes                              |
| Argument forwarding          | Yes                              | Yes                              |
| Meta-programming             | Yes                              | Yes                              |
| `public`/`private`/`protected` | Yes                            | Yes, same syntax as C++          |
| Build system and dependency management freedom? `*¹` | Yes      | Yes, but optionally has a package manager you don't need to use |
| `inline` keyword             | Yes                              | No, use `pragma(inline)` instead |
| lambda functions             | Yes, `[]{}`, `[](args){}`, `[]()->returnType{}` | Yes, `{}`, `(args){}`, `delegate()` |


`*¹`: The programming language doesn't force you to use a specific ecosystem like *cough*Go*cough*.

<br>

I yet need to figure out more about D's memory management. On things I'm unsure or I still
need to learn/figure out I added a `??`. Table is not complete yet.


https://dlang.org/spec/version.html
