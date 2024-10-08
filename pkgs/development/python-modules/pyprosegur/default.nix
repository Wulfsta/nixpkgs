{
  lib,
  aiofiles,
  aiohttp,
  backoff,
  buildPythonPackage,
  click,
  fetchFromGitHub,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pyprosegur";
  version = "0.0.11";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "dgomes";
    repo = "pyprosegur";
    rev = "refs/tags/${version}";
    hash = "sha256-DBr/MtomB7MlZlK8YBvtY1MIstLxotOkv07zZNNuRtM=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    aiofiles
    aiohttp
    backoff
    click
  ];

  # Project has no tests
  doCheck = false;

  pythonImportsCheck = [ "pyprosegur" ];

  meta = with lib; {
    description = "Python module to communicate with Prosegur Residential Alarms";
    homepage = "https://github.com/dgomes/pyprosegur";
    changelog = "https://github.com/dgomes/pyprosegur/releases/tag/${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
    mainProgram = "pyprosegur";
  };
}
