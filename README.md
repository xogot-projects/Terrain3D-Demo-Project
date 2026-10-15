# Terrain3D Sample Project

This sample project is taken directly from the [`project` directory of Terrain3D](https://github.com/TokisanGames/Terrain3D/tree/main/project), created by TokisanGames and the Terrain3D contributors.

This repository contains just the sample project to make it easy to include a working Terrain3D example in Xogot's Learning Center.

For documentation, updates, and more information, visit the [main Terrain3D project](https://github.com/TokisanGames/Terrain3D).

See [LICENSE.txt](LICENSE.txt) for the original MIT license and copyright notice.

## Xogot Learning Center package

This sample targets Godot 4.7 and pairs the Terrain3D 1.0.2 stable editor add-on with its official native libraries, matching Xogot's bundled iPad extension. The unreleased 1.1 ocean effect is omitted; the terrain, foliage, tunnel, player, and navigation examples remain.

Tagged packages include the verified native libraries and imported project assets. When cloning the source, run `python3 .github/scripts/prepare_terrain.py` before opening the project. The command verifies the pinned upstream archive SHA-256. iPad uses Xogot's bundled native extension.

The main demo uses GDScript and needs no .NET component. Optional upstream C# reference code and project templates are under `demo/csharp`.

## Touch and controller controls

Xogot’s iOS virtual controller is enabled. Use the left stick for WASD movement and the right stick to look. A rises/jumps (E or Space), and B descends (Q). The unused X/Y virtual buttons are disabled. Bluetooth controllers use the same bindings. Keyboard/mouse controls and the V/G/C toggles remain available.
