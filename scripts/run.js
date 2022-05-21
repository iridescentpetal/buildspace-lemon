const main = async () => {
    const [owner, mysteryWaver] = await hre.ethers.getSigners();

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();

    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("A message!");
    await waveTxn.wait(); // Wait for the transaction to be mined

    await waveContract.getTotalWaves();

    await waveContract.connect(mysteryWaver).wave("mystery waver is waving!");

    await waveContract.getTotalWaves();

    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Another message!");
    await waveTxn.wait(); // Wait for the transaction to be mined

    console.log('owner\'s waves:', await waveContract.getTotalWavesForAddress(owner.address));
    console.log('mysteryWaver\'s waves', await waveContract.getTotalWavesForAddress(mysteryWaver.address));

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
  };
  
  async function runMain() {
    try {
        await main();
        process.exit(0); // exit Node process without error
    } catch (error) {
        console.log(error);
        process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
}
  
  runMain();