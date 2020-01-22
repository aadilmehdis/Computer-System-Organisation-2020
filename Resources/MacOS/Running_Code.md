# Instruction to assemble and run programs
## Step 1
- Write an assembly code and save it with a `.s` extension.
- In your assembly code instead of declaring the start label of your program as `_start`, use `_main`. (It's a Mac thing, find out why.)
- For example, `hello.s`.
## Step 2
- Assemble your program using the following instruction,
    - `as -g hello.s -o hello.o`
- `as` are Mac OS X Mach-O GNU-based assemblers
- `-o` is the flag for naming the output file name instead of a.out.
- `-g` is the flag for Produce  debugging information for the symbolic debugger `gdb(1)` so that the assembly source can be debugged symbolically.
- Use man page to learn more about this command.

## Step 3
- Link your program using the following instruction,
    - `ld hello.o -e _main -o hello   -macosx_version_min 10.14 -arch x86_64 -lSystem`
    - The ld command combines several object files and libraries, resolves references, and produces an ouput file.  ld can produce a final linked image (executable, dylib, or bundle), or with the -r option, produce another object file.  If the -o option is not used, the output file produced is named "a.out".
    - Make sure to get this command right.
    - Learn more about this command on MAN pages.

## Step 4
- Now you should have your executable. You can run the code using `./hello`.

## Run with GDB
- Run the following,
    - `gdb ./hello`
- Insert break points in the starting of the program frame
    - `b 1`
    - `b 2`
    - `b 3`
    - This sets a break point on the first line of your code.
- Run your program
    - `run`
- Execute each command line by line
    - `stepi`
- Check the status of the registers,
    - `info registers`