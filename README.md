# Hello D from CMake

Simple test to use CMake with D.

**Dependencies**:

 - https://github.com/magiruuvelvet/gentoo-overlay/tree/master/dev-util/cmake-d (package for https://github.com/dcarp/cmake-d)


In real world applications those CMake files should be added to the project source though,
because nobody is gonna install those modules globally on their system.


## My comparisons of what I figured out so far

I made this table mainly for myself as cheat sheet.

|                              |   C++                            | D                                |
|------------------------------|----------------------------------|----------------------------------|
| Entry Point                  | `int main(...)`                  | `int main(...)` or `void main()` |
| Multi-paradigm               | Yes                              | Yes                              |
| Runtime Reflections          | No                               | No`??`                           |
| Preprocessor                 | Yes                              | No, but has `version()` for compile-time environmental checks |
| Memory Management            | RAII / Smart Pointer             | Garbage Collector / RAII`??`     |
| Scopes                       | Yes                              | Yes                              |
| Function Overloading         | Yes                              | Yes                              |
| Operator Overloading         | Yes, uses operators              | Yes, uses named functions        |
| Abstract Classes             | Yes, `method() = 0`              | Yes, `abstract class`            |
| Interfaces                   | No, use abstract classes         | Yes                              |
| Polymorphism                 | Yes                              | Yes                              |
| OOP: `override`              | Yes, after method name           | Yes, before return type          |
| Constructor Name             | Equals class name                | `this()`                         |
| Destructors                  | Yes, `~ClassName()`              | Yes, `~this()`                   |
| Destructor automatically called when out of scope? | Yes        | Yes and No`??` (Garbage Collector) |
| Templates                    | Yes                              | Yes                              |
| Templates with variadic args | Yes                              | Yes                              |
| Variadic args                | Yes                              | `??`                             |
| Argument forwarding          | Yes                              | `??`                             |
| Meta-programming             | Yes                              | Yes                              |
| `public`/`private`/`protected` | Yes                            | Yes, same syntax as C++          |
| Build system and dependency management freedom? `*¹` | Yes      | Yes, but optionally has a package manager you don't need to use |
| `inline` keyword             | Yes                              | No                               |


`*¹`: The programming language doesn't force you to use a specific ecosystem like *cough*Go*cough*.

<br>

I yet need to figure out more about D's memory management. On things I'm unsure or I still
need to learn/figure out I added a `??`. Table is not complete yet.
