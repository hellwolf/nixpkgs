{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  pytestCheckHook,
  pytest-xdist,
  typing-extensions,
  setuptools,
}:

buildPythonPackage rec {
  pname = "eth-typing";
  version = "5.1.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-typing";
    tag = "v${version}";
    hash = "sha256-IOWd6WFPAYO+VZwlMilRVHtudEjHt5p8Xu4WloFB/ww=";
  };

  build-system = [ setuptools ];

  dependencies = [ typing-extensions ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-xdist
  ];

  pythonImportsCheck = [ "eth_typing" ];

  disabledTests = [ "test_install_local_wheel" ];

  meta = {
    changelog = "https://github.com/ethereum/eth-typing/blob/v${version}/docs/release_notes.rst";
    description = "Common type annotations for Ethereum Python packages";
    homepage = "https://github.com/ethereum/eth-typing";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ siraben ];
  };
}
