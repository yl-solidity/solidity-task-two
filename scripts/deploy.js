// scripts/deploy.js
const hre = require("hardhat");

async function main() {
  const SimpleERC20 = await hre.ethers.getContractFactory("ERC20");
  const token = await SimpleERC20.deploy(
    "MyToken",       // 代币名称
    "MTK",          // 代币符号
    "1000000"       // 初始供应量
  );

  await token.deployed();
  console.log("Token deployed to:", token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});