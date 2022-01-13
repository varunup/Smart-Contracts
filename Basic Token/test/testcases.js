const TARTARUS = artifacts.require("TARTARUS");

contract("TARTARUS", () => {

    let instance = null;

    beforeEach( async () => {
        instance = await TARTARUS.deployed();
    });
    
    it("TARTARUS", async () => {
        assert(instance)
    });

    it( "Total Supply", async () => {
        const result  = await instance.totalSupply();
        assert.equal(result.toString(),"10000000000000000000000000000");
    });

    it("Token Name", async () => {
        const result  = await instance.name();
        assert.equal(result.toString(), "TARTARUS")
    });

    it("Token decimal count", async () => {
        const result = await instance.decimal();
        assert.equal(result.toNumber(), 18)
    });

    it("Token Symbol", async () => {
        const result  = await instance.symbol();
        assert.equal(result.toString(), "TART")
    });

    it("Should give balance of given address", async () => {
        await instance.transfer("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7", 1000000)
        //const result = await instance.balanceOf("0x6C34498E696C55401c9BfAE12dA1589B42449275");
        const result_1 = await instance.balanceOf("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7");
        assert.equal(result_1.toNumber(), 1000000);
    });

    it("Should transfer amount from sender to owner", async () => {
        try{
            await instance.approve("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7", 100000);
            const result = await instance.transferFrom("0x6C34498E696C55401c9BfAE12dA1589B42449275", "0xD13C5AFF45876b75E294C985532Ed86427253e9C", 10000,
            {from :"0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7"});

            const result1 = await instance.balanceOf("0xD13C5AFF45876b75E294C985532Ed86427253e9C");
            const result2 = await instance.balanceOf("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7");
            
            assert(result);
            assert.equal(result1.toNumber(), 10000);
            assert.equal(result2.toNumber(), 1000000);
        }catch(error){
            assert.equal(error.message, "reverted", "Sender does not have required amount of token");
        };
    });

    it("Should return the allowance for the delegate", async () => {
        await instance.approve("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7", 10000000);
        const result  = await instance.allowance("0x6C34498E696C55401c9BfAE12dA1589B42449275", "0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7");
        assert.equal(result.toNumber(), 10000000);
    });

    it("Should transfer amount from owner to reciver address", async () => {
        try{
            await instance.transfer("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7", 10000);
            //const result = await instance.balanceOf("0x6C34498E696C55401c9BfAE12dA1589B42449275");
            const result = await instance.balanceOf("0x3796Fc977a2156b080ADE776Fa5b1dDf16624bc7");
            //assert.equal(result.toNumber(), 110000);
            assert.equal(result.toNumber(), 1010000);
        }catch(error){
            assert.equal(error.message, "Owner does not have required amount of token");
        };
    });

    it("Should check for the return of approve function", async () => {
        await instance.approve("0xD13C5AFF45876b75E294C985532Ed86427253e9C", 1000);
        const result  = await instance.allowance("0x6C34498E696C55401c9BfAE12dA1589B42449275", "0xD13C5AFF45876b75E294C985532Ed86427253e9C");
        assert.equal(result.toNumber(), 1000);
    });

});