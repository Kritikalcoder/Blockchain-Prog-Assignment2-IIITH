var expectThrow = require('./helper.js');
const Quiz = artifacts.require("Quiz");

contract("Quiz", async(accounts) => {
    var quiz;  

    it("tests that two people can't register as quiz master", async () => {
        quiz = await Quiz.new({from: accounts[0]});
        let res1 = await quiz.register_quiz_master({from: accounts[0]});
        let res2 = quiz.register_quiz_master({from: accounts[1]}); 
        await expectThrow(res2);
    })

    it("tests that only quiz master can add questions", async () => {
        let res1 = quiz.add_question("Which is the greatest? - 1. 1 2. 2 3. 3 4. 4", 4, {from: accounts[1]});
        await expectThrow(res1);
    })

    it("tests for questions with valid answers", async () => {
        let res1 = quiz.add_question("Which is the greatest? - 1. 1 2. 2 3. 3 4. 4", 5, {from: accounts[0]});
        await expectThrow(res1);
    })

    it("tests that player can't register before start of registration", async () => {
        let res1 = quiz.register_player({from: accounts[1]});
        await expectThrow(res1);
    })

    it("tests that quiz master can't add questions after start of registration", async () => {
        let res4 = await quiz.add_question("Which is the greatest? - 1. 1 2. 2 3. 3 4. 4", 4, {from: accounts[0]});
        let res5 = await quiz.add_question("Which is the smallest? - 1. 1 2. 2 3. 3 4. 4", 1, {from: accounts[0]});
        let res6 = await quiz.add_question("Which is an even prime? - 1. 1 2. 2 3. 3 4. 4", 2, {from: accounts[0]});
        let res7 = await quiz.add_question("Which is an odd prime? - 1. 1 2. 2 3. 3 4. 4", 3, {from: accounts[0]});
        let res1 = await quiz.start_registration(10, 10, 40, {from: accounts[0]});
        let res2 = await quiz.register_player({from: accounts[1]});
        let res3 = quiz.add_question("Which is an even prime? - 1. 1 2. 2 3. 3 4. 4", 2, {from: accounts[0]});
        await expectThrow(res3);
    })

});