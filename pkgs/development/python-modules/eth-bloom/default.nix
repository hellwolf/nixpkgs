{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  eth-hash,
  hypothesis,
  pytestCheckHook,
  pytest-xdist,
  setuptools,
}:

buildPythonPackage rec {
  pname = "eth-bloom";
  version = "3.1.0";

  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-bloom";
    rev = "refs/tags/v${version}";
    hash = "sha256-WrBLFICPyb+1bIitHZ172A1p1VYqLR75YfJ5/IBqDr8=";
  };

  build-system = [ setuptools ];

  dependencies = [ eth-hash ];

  nativeCheckInputs = [
    hypothesis
    pytestCheckHook
    pytest-xdist
  ] ++ eth-hash.optional-dependencies.pycryptodome;

  pythonImportsCheck = [ "eth_bloom" ];

  disabledTests = [ "test_install_local_wheel" ];

  meta = {
    changelog = "https://github.com/ethereum/eth-bloom/blob/v${version}/CHANGELOG.rst";
    description = "Implementation of the Ethereum bloom filter";
    homepage = "https://github.com/ethereum/eth-bloom";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.FlorianFranzen ];
  };
}
