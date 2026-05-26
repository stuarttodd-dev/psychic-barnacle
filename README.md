# Foolsupdate / Psych Engine Setup

This repo contains both:

- a clean macOS Psych Engine app
- a patched macOS app with `foolsupdate` already applied
- the patch files by themselves
- the original zip archives for reference

## Quick Start

If you just want to play `foolsupdate` on macOS, run this:

- `psych-engine-foolsupdate/PsychEngine.app`

From Terminal:

```bash
open "psych-engine-foolsupdate/PsychEngine.app"
```

If macOS blocks it:

1. Right-click `psych-engine-foolsupdate/PsychEngine.app`
2. Click `Open`
3. Click `Open` again on the warning

That is the easiest path. You do not need to patch anything manually if you use `psych-engine-foolsupdate/`.

## What Each Folder Is For

- `psych-engine/`
  - Clean base Psych Engine app for macOS.
  - Use this if you want an unpatched copy.
- `psych-engine-foolsupdate/`
  - Ready-to-run macOS app with the `foolsupdate` patch already applied.
  - This is the main thing most people should launch.
- `foolsupdate-patch/`
  - Patch source files only.
  - Use this if you want to apply the patch yourself to a fresh app.
- `archives/`
  - Original zip files:
    - `archives/PsychEngine-MacOS.zip`
    - `archives/foolsupdate_95899.zip`

## How To Run It

### Easiest way

Launch:

- `psych-engine-foolsupdate/PsychEngine.app`

or:

```bash
open "psych-engine-foolsupdate/PsychEngine.app"
```

### If you want the clean base engine instead

Launch:

- `psych-engine/PsychEngine.app`

or:

```bash
open "psych-engine/PsychEngine.app"
```

## How To Apply The Patch Manually

You only need this section if you want to rebuild the patched app yourself.

### 1. Start from the clean app

Use:

- `psych-engine/PsychEngine.app`

### 2. Make a backup first

Copy `psych-engine/PsychEngine.app` before patching it.

This mod is buggy, so keeping a clean backup is strongly recommended.

### 3. Copy the patch into the app bundle

Copy everything from:

- `foolsupdate-patch/Contents/Resources/`

into:

- `psych-engine/PsychEngine.app/Contents/Resources/`

### Finder method

1. Right-click `psych-engine/PsychEngine.app`
2. Click `Show Package Contents`
3. Open `Contents/Resources/`
4. Copy everything from `foolsupdate-patch/Contents/Resources/` into that folder
5. Allow Finder to merge and replace files

### Terminal method

```bash
cp -R "foolsupdate-patch/Contents/Resources/." "psych-engine/PsychEngine.app/Contents/Resources/"
```

After that, run:

```bash
open "psych-engine/PsychEngine.app"
```

If you want to keep the patched app separate, duplicate `psych-engine/PsychEngine.app` first and patch the copy.

## Recommended Way To Use This Repo

If you are not developing or rebuilding anything:

1. Ignore `psych-engine/`
2. Ignore `foolsupdate-patch/`
3. Run `psych-engine-foolsupdate/PsychEngine.app`

## Windows Notes

For Windows, use the original Windows-style release archive:

- `archives/foolsupdate_95899.zip`

After extracting it on Windows, run:

- `bin/BFDI26.exe`

Do not copy the Windows runtime files into the macOS `.app` bundle.

## Known Issues

- `foolsupdate` is still buggy. Expect crashes, warnings, or odd scripting behavior.
- This repo has been cleaned up so the macOS app is much easier to launch, but the mod itself is not fully polished.
- Some packaging issues were fixed to make the patch usable on macOS.
- The folder typo `VEE2/scipts` was normalized to `VEE2/scripts`.

## Short Version

If you only read one line, read this:

```bash
open "psych-engine-foolsupdate/PsychEngine.app"
```
