{ inputs, ... }:

{
  flake.overlays.simulators = final: prev: {
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (py-final: py-prev: {
        gym3 = py-final.callPackage ./gym3 { };
        mujoco-menagerie = py-final.callPackage ./mujoco-menagerie { };
        mujoco-mjx = py-final.callPackage ./mujoco-mjx { };
      })
    ];
    physx5 = final.callPackage ./physx5/default.nix {};
    physx5-gpu = final.callPackage ./physx5/gpu.nix {};
  };

  perSystem = { pkgs, lib, ... }: {
    packages = {
      inherit (pkgs.python3Packages) gym3 mujoco-menagerie mujoco-mjx;
      inherit (pkgs) physx5 physx5-gpu;
    };

    devShells.simulators = pkgs.mkShell {
      name = "simulators";

      packages = with pkgs; [
        (python3.withPackages
          (p: with p; [ gym3 mujoco mujoco-mjx mujoco-menagerie ]))
        physx5
        physx5-gpu
      ];
    };
  };
}
