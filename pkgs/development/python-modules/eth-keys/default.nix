{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  asn1tools,
  coincurve,
  eth-hash,
  eth-typing,
  eth-utils,
  factory-boy,
  hypothesis,
  isPyPy,
  pyasn1,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "eth-keys";
  version = "0.6.0";

  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-keys";
    rev = "refs/tags/v${version}";
    hash = "sha256-HyOfuzwldtqjjowW7HGdZ8RNMXNK3y2NrXUoeMlWJjs=";
  };

  build-system = [ setuptools ];

  dependencies = [
    eth-typing
    eth-utils
  ];

  nativeCheckInputs =
    [
      asn1tools
      factory-boy
      hypothesis
      pyasn1
      pytestCheckHook
    ]
    ++ optional-dependencies.coincurve
    ++ lib.optional (!isPyPy) eth-hash.optional-dependencies.pysha3
    ++ lib.optional isPyPy eth-hash.optional-dependencies.pycryptodome;

  pythonImportsCheck = [ "eth_keys" ];

  optional-dependencies = {
    coincurve = [ coincurve ];
  };

  meta = {
    changelog = "https://github.com/ethereum/eth-keys/blob/v${version}/CHANGELOG.rst";
    description = "Common API for Ethereum key operations";
    homepage = "https://github.com/ethereum/eth-keys";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.FlorianFranzen ];
  };
}
