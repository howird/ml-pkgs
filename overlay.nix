final: prev: rec {
  python3 = prev.python3.override {
    packageOverrides = pyFinal: pyPrev: rec {
      pytorchWithCuda11 = pyPrev.pytorchWithCuda.override {
        cudatoolkit = prev.cudatoolkit_11_2;
        nccl = prev.nccl_cudatoolkit_11;
        cudnn = prev.cudnn_cudatoolkit_11_2;
        magma = prev.magma.override {
          cudatoolkit = prev.cudatoolkit_11_2;
        };
      };

      torchvisionWithCuda11 = pyPrev.torchvision.override {
        pytorch = pytorchWithCuda11;
      };

      pytorchvizWithCuda11 = pyFinal.callPackage ./pkgs/pytorchviz {
        pytorch = pytorchWithCuda11;
      };

      atari-py-with-rom = pyFinal.callPackage ./pkgs/atari-py-with-rom {};

      py-glfw = pyFinal.callPackage ./pkgs/py-glfw {};

      gym3 = pyFinal.callPackage ./pkgs/gym3 {};

      procgen = pyFinal.callPackage ./pkgs/procgen {};

      redshift-connector = pyFinal.callPackage ./pkgs/redshift-connector {};

      awswrangler = pyFinal.callPackage ./pkgs/awswrangler {};
    };
  };

  python3Packages = python3.pkgs;
}
