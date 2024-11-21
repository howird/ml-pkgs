{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonRelaxDepsHook
, python
, stdenv
, autoPatchelfHook
, numpy
, scipy
, dacite
, gymnasium
, sapien
, h5py
, pyyaml
, tqdm
, gitpython
, tabulate
, transforms3d
, trimesh
, imageio
, imageio-ffmpeg
, mplib
# , fast-kinematics
, ipython
, pytorch-kinematics
, tyro
, huggingface-hub
, pynvml
, psutil
, stable-baselines3
}:

buildPythonPackage rec {
  pname = "maniskill";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "howird";
    repo = pname;
    rev = "37b7d751a2133390db06fceb2900696287d87124";
    hash = "sha256-PFlMuy7VxW9WMfZJIuE3xvuPOnP6T3StfR8FY0AEl0g=";
  };

  propagatedBuildInputs = [
    numpy
    scipy
    dacite
    gymnasium
    sapien
    h5py
    pyyaml
    tqdm
    gitpython
    tabulate
    transforms3d
    trimesh
    imageio
    imageio-ffmpeg
    mplib
    # fast-kinematics
    ipython
    pytorch-kinematics
    tyro
    huggingface-hub
    pynvml
    psutil
    stable-baselines3
  ];

  pythonImportsCheck = [ "mani_skill" ];
  
  # check requires pip and network
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/haosulab/ManiSkill";
    description = ''
      ManiSkill3: A Unified Benchmark for Generalizable Manipulation Skills.
    '';
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
    platforms = with platforms; linux;
  };
}
