{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  einops,
  ninja,
  #triton,
  setuptools,
  symlinkJoin,
  torch,

  rocmSupport ? torch.rocmSupport,
  rocmPackages ? { },
}:

buildPythonPackage rec {
  pname = "flash-attention";
  version = "a00ddeb2b8f8a68b2e03b7bee5980e819069cdd1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Dao-AILab";
    repo = "flash-attention";
    rev = "${version}";
    hash = "sha256-CyJbnAtIQXD8MF0whjPg3pILY2FZIsaXYcKAefsFrJs=";
    fetchSubmodules = true;
  };

  preConfigure = ''
    export MAX_JOBS="$NIX_BUILD_CORES"
  '';

  env = {
    FLASH_ATTENTION_TRITON_AMD_ENABLE = "TRUE";
    ROCM_PATH = "${rocmPackages.clr}";
    ROCM_HOME = "${rocmPackages.clr}";
  };

  build-system = [
    ninja
    setuptools
  ];

  buildInputs = [
  ];

  dependencies = [
    einops
    torch
    #triton
  ];

  # Requires NVIDIA driver.
  doCheck = false;

  pythonImportsCheck = [ ];

  meta = {
    description = "Official implementation of FlashAttention and FlashAttention-2";
    homepage = "https://github.com/Dao-AILab/flash-attention/";
    changelog = "https://github.com/Dao-AILab/flash-attention/releases/tag/${src.tag}";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ jherland ];
  };
}
