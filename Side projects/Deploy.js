const ethers = require("ethers");
// const solc = require("solc")
const fs = require("fs"); // to read from files
// require("dotenv").config();

async function main() {
  // First, compile this!
  // And make sure to have your ganache network up!
  const provider = new ethers.providers.JsonRpcProvider(
    "http://192.168.202.112:8545"
  ); // provide connection to blockchain
  const wallet = new ethers.Wallet(
    "5364525fc55bbac0099a35f082278fa103cb780a6246f38c2a0e77717d94f163",
    provider
  ); // takes in pvt key and provider. Taking in pvt key is a huge no no. provide wallet to peform blockchain transactions.
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  
   const contractFactory = new ethers.ContractFactory(abi, binary, wallet); //Contractfactory is an object to deply contracts
  console.log("Deploying, please wait...");
  const contract = await contractFactory.deploy(); //STOP here! WAit for contract to deploy
  console.log(contract);
  
  }

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
