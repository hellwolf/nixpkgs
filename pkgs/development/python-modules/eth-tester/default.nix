{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchpatch2,
  pythonOlder,
  eth-abi,
  eth-account,
  eth-keys,
  eth-utils,
  pydantic,
  pytestCheckHook,
  pytest-xdist,
  py-evm,
  rlp,
  semantic-version,
  setuptools,
}:

buildPythonPackage rec {
  pname = "eth-tester";
  version = "0.12.0-beta.2";

  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-tester";
    rev = "refs/tags/v${version}";
    hash = "sha256-ox7adsqD0MPZFcxBhino8cgwYYEWrBnD+ugPQOuOO2U=";
  };

  build-system = [ setuptools ];

  dependencies = [
    eth-abi
    eth-account
    eth-keys
    eth-utils
    pydantic
    rlp
    semantic-version
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-xdist
    py-evm
  ];

  pythonImportsCheck = [ "eth_tester" ];

  meta = {
    changelog = "https://github.com/ethereum/eth-tester/blob/v${version}/CHANGELOG.rst";
    description = "Tool suite for testing ethereum applications";
    homepage = "https://github.com/ethereum/eth-tester";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.FlorianFranzen ];
  };
}
