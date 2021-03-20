# Hello D from CMake

Learning D as C++20 programmer and using CMake for building.

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
| Runtime Reflections          | No                               | No                               |
| Compile-time Reflections     | meta-programming, limited functionality | Yes, has traits and more to make lots of magic possible |
| Preprocessor                 | Yes                              | No, but has `version()` for compile-time environmental checks |
| Preprocessor Macros          | Yes, pass in custom values at build time using `-DMYVALUE=123` | No, only way to pass in custom configured values is using CMake `configure_file` magic |
| Memory Management            | RAII / Smart Pointer             | Garbage Collector / RAII         |
| Scopes                       | Yes                              | Yes                              |
| Function Overloading         | Yes                              | Yes                              |
| Operator Overloading         | Yes, uses operators              | Yes, uses named functions        |
| Class                        | Yes, no allocation restrictions  | Yes, HEAP only (`new`) or `scoped!T` |
| Struct                       | Yes, no allocation restrictions  | Yes, no allocation restrictions  |
| Class == Struct              | Yes, besides default visibility  | No                               |
| Default Class Visibility     | `private`                        | `public`                         |
| Default Struct Visibility    | `public`                         | `public`                         |
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
| Inheritance with classes     | Yes                              | Yes                              |
| Inheritance with structs     | Yes                              | No (why though?)                 |
| Templates                    | Yes                              | Yes                              |
| Templates with variadic args | Yes                              | Yes                              |
| Template arguments with data types | Yes                        | Yes                              |
| Template arguments with literal values | Yes                    | Yes                              |
| Template restrictions (specific data types, etc.) | Yes         | Yes                              |
| Variadic args                | Yes                              | Yes                              |
| Argument forwarding          | Yes                              | Yes                              |
| Meta-programming             | Yes                              | Yes                              |
| `public`/`private`/`protected` | Yes                            | Yes, same syntax as C++          |
| Build system and dependency management freedom? `*¹` | Yes      | Yes, but optionally has a package manager you don't need to use |
| `inline` keyword             | Yes                              | No, use `pragma(inline)` instead |
| lambda functions             | Yes, `[]{}`, `[](args){}`, `[]()->returnType{}` | Yes, `{}`, `(args){}`, `delegate()`, `function()` |
| lambda capture outer variables | Yes, `[&]`, `[=]`              | `delegate()` is capturing, `function()` is NOT |
| `auto` keyword               | Yes                              | Yes                              |
| Built-in unit testing        | No                               | Yes                              |
| Build-in Unicode support     | No                               | Yes, UTF-8/16/32                 |
| Compile-time expressions     | Yes, `constexpr`, etc.           | Yes, uses `static` for this at some places, like `static if` |


`*¹`: The programming language doesn't force you to use a specific ecosystem like *cough*Go*cough*.

<br>

About **Modules**: you can freely access `private` class/struct members inside the same module which declared it.
Watch out for stupid bugs, because the compiler didn't yell about `private`. This feature is supposed to make
C++ `friend` keyword obsolete, but also can be dangerous if not paying attention. I may or may not like it.

<br>

I yet need to figure out more about D's memory management. On things I'm unsure or I still
need to learn/figure out I added a `??`. Table is not complete yet.


https://dlang.org/spec/version.html

https://dlang.org/articles/cpptod.html
