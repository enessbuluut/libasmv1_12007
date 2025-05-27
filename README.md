# 📘 libasmv1_12007 – C Library Functions Written in x86 Assembly

This project contains implementations of standard C library functions (`strcpy`, `strcmp`, `strcat`, and even `scanf`) written entirely in **x86 Assembly language**. All functions are assembled with **NASM** and compiled into `.obj` files compatible with **MSVC (Visual Studio 2022)**.

This is ideal for learning system programming, low-level development, and understanding how C libraries work under the hood.

---

## 📁 Directory Structure

```
libasmv1_12007/
├── Functions/
│   ├── obj_files/           → Compiled `.obj` files
│   └── src/                 → Assembly source files
│       ├── strcat.asm
│       ├── strcmp.asm
│       ├── strcpy.asm
│       ├── scanf/
│       │   └── scanf.asm    → More complex and lengthy implementation
│       └── ...              → Other functions
├── test/
│   ├── test_strcpy.c
│   ├── test_strcat.c
│   ├── test_strcmp.c
│   ├── test_scanf.c
│   └── ...                  → Separate test files for each function
```

---

## ✅ Implemented Functions

| Function     | Description                              |
|--------------|------------------------------------------|
| `strcat`     | Concatenates two strings                  |
| `strchr`     | Finds first occurrence of a character     |
| `strcmp`     | Compares two strings                      |
| `strcpy`     | Copies a string                           |
| `strcpy_s`   | Safe version of string copy               |
| `strncmp`    | Compares first N characters               |
| `strncpy`    | Copies N characters                       |
| `strncpy_s`  | Safe version of strncpy                   |
| `strrchr`    | Finds last occurrence of a character     |
| `strstr`     | Searches for a substring                   |
| `scanf`      | Reads formatted input from console (Windows API) |

---

## 🔨 Build Instructions

### Create `.obj` files using NASM

```bash
nasm -f win32 Functions/src/strcpy.asm -o Functions/obj_files/strcpy.obj
```

Use this command for each `.asm` file to generate `.obj` files.

> ℹ️ Function names in Assembly start with an underscore (`_strcpy` etc.). This is necessary for MSVC compatibility. If using GCC or other compilers, you may need to adjust naming conventions.

### Compile Tests with MSVC (Visual Studio 2022)

In the **Developer Command Prompt** for Visual Studio:

```bash
cd test
cl test_strcpy.c ..\Functions\obj_files\strcpy.obj
```

Specify the test source and corresponding `.obj` file for each function.

---

## 🧪 Testing

Each function has its own dedicated `test_*.c` file to:

- Test functions independently
- Easily detect errors
- Provide clear usage examples

Example:

```bash
cl test_strcat.c ..\Functions\obj_files\strcat.obj
```

---

## ⚙️ Platform Details

This project targets:

- **Windows x86 (32-bit)** platform  
- `.obj` files are fully compatible with **MSVC Linker**  
- Uses the **cdecl calling convention**

If you want to run on other platforms:

| Platform | NASM Format | Additional Notes           |
|----------|-------------|----------------------------|
| Linux    | `-f elf32`  | Calling convention adjustments needed |
| Win64    | `-f win64`  | 64-bit registers required   |
| GCC      | `-f elf32`  | Remove `_` prefix from symbols |

---

## 📄 License

MIT License – Feel free to use, modify, and share this project.
