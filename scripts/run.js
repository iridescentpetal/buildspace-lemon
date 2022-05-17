const main = async () => {
    const [owner, mysteryWaver] = await hre.ethers.getSigners();

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();

    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);

    await waveContract.getTotalWaves();
    await waveContract.wave();
    await waveContract.wave();

    await waveContract.getTotalWaves();

    await waveContract.connect(mysteryWaver).wave();

    await waveContract.getTotalWaves();

    console.log('owner has waved %d times', await waveContract.getTotalWavesForAddress(owner.address));
    console.log('mysteryWaver has waved %d times', await waveContract.getTotalWavesForAddress(mysteryWaver.address));

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