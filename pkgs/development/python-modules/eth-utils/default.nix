{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchpatch2,
  isPyPy,
  pythonOlder,
  cytoolz,
  eth-hash,
  eth-typing,
  hypothesis,
  pytestCheckHook,
  pytest-xdist,
  setuptools,
  toolz,
  mypy,
}:

buildPythonPackage rec {
  pname = "eth-utils";
  version = "5.1.0";
  pyproject = true;

  build-system = [ setuptools ];

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-utils";
    rev = "v${version}";
    hash = "sha256-uPzg1gUEsulQL2u22R/REHWx1ZtbMxvcXf6UgWqkDF4=";
  };

  propagatedBuildInputs =
    [
      eth-hash
      eth-typing
    ]
    ++ lib.optional (!isPyPy) cytoolz
    ++ lib.optional isPyPy toolz;

  nativeCheckInputs = [
    hypothesis
    mypy
    pytestCheckHook
  ] ++ eth-hash.optional-dependencies.pycryptodome;

  pythonImportsCheck = [ "eth_utils" ];

  disabledTests = [ "test_install_local_wheel" ];

  meta = with lib; {
    changelog = "https://github.com/ethereum/eth-utils/blob/${src.rev}/docs/release_notes.rst";
    description = "Common utility functions for codebases which interact with ethereum";
    homepage = "https://github.com/ethereum/eth-utils";
    license = licenses.mit;
    maintainers = with maintainers; [ siraben ];
  };
}
