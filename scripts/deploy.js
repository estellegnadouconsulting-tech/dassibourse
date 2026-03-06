const hre = require("hardhat");

async function main() {

  const Compliance = await hre.ethers.getContractFactory("Compliance");
  const compliance = await Compliance.deploy();

  await compliance.waitForDeployment();

  const AssetToken = await hre.ethers.getContractFactory("AssetToken");
  const token = await AssetToken.deploy(
      "Dassi Asset",
      "DASS",
      compliance.target
  );

  await token.waitForDeployment();

  console.log("Compliance:", compliance.target);
  console.log("AssetToken:", token.target);

}

main();
