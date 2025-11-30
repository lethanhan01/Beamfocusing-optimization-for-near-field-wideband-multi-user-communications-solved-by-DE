# MATLAB Project

This is a minimal MATLAB project scaffold for IT4593.

## Structure

- `src/`: Source functions and entry script
- `tests/`: Simple test script

## Quick Start

1. Open MATLAB or use PowerShell with `matlab` on PATH.
1. Run the main script:

```powershell
# From this folder
matlab -batch "run('matlab/src/main.m')"
```

1. Run tests:

```powershell
matlab -batch "run('matlab/tests/test_main.m')"
```

If `matlab` is not on PATH, open MATLAB, set the current folder to this project, then run `src/main.m` and `tests/test_main.m`.

## Notes

- Tested with MATLAB R2021b+; adjust as needed.
- You can expand with packages (`+pkg` folders) or classes (`@ClassName`).
