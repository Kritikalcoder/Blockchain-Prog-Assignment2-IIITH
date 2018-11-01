pragma solidity ^0.4.24;

contract Quiz{

    address[] players_adds;

    uint N;
    uint player_count;
    uint starttime;
    uint endtime;
    uint question_count;
    uint total_pfee;
    address quiz_master;
    bool quiz_master_reward_collected;
    bool registration_started;
    uint time;

    constructor() public {
        N = 10;
        player_count = 0;
        starttime = 0;
        endtime = 0;
        question_count = 0;
        total_pfee = 0;
    }

    modifier onlyQuizMaster () {
        require (msg.sender == quiz_master, "not the quiz master");
        _;
    }
    modifier quizmasterDoesNotExist () {
        require (quiz_master == 0, "Quiz master exists");
        _;
    }

    modifier onlyBy(address _account) {
        require(msg.sender == _account, "Late");
        _;
    }

    modifier onlyBefore(uint _time) {
        require(block.number < _time, "too late");
        _;
    }

    modifier onlyAfter(uint _time) {
        require(block.number > _time, "too early");
        _;
    }

    modifier isRegistered(address _add) {
        require(add_to_player[_add].pending == true || add_to_player[_add].paid == true, "Not registered");
        _;
    }

    modifier hasPaid(address _add) {
        require(add_to_player[_add].paid == true, "Not paid");
        _;
    }

    modifier hasPaidorQuizMaster(address _add) {
        require(add_to_player[_add].paid == true || _add == quiz_master, "Not a part of the system");
        _;
    }

    modifier hasNotAnsweredQuestion (address _add, uint _qno) {
        require(question_details[_qno - 1].answers[_add] == 0, "Already Answered");
        _;
    }

    modifier playerCountInLimit() {
        require (player_count > 0 && player_count <= N);
        _;
    }



    struct Player {
        uint p_fee;
        uint reward;
        uint answer;
        bool pending;
        bool paid;
        bool is_reward_collected;
    }

    struct Question {
        uint starttime;
        uint endtime;
        string text;
        uint correct_ans;
        mapping (address => uint) answers;
        bool won_over;
        address winner;
    }

    struct QuizMaster {
        address add;
    }

}