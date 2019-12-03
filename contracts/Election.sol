pragma solidity ^0.5.8;
	
contract Election {
	//候选者结构体 Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
	

	mapping(address => bool) public voters;
	//候选者id到结构体的映射
	mapping(uint => Candidate) public candidates;
	
	//总共多少候选者
	uint public candidatesCount;

	event votedEvent(uint indexed _candidateId);
	
	//构造函数
	constructor() public { 
		addCandidate("Stephen Curry"); //Candidate 1
		addCandidate("Lebron James");
	}
	
	//添加候选者
	function addCandidate(string memory _name ) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount,_name,0);
	}

	function vote(uint _candidateId) public {
		//要求投票者从没投过票
		require(!voters[msg.sender]);  //msg.sender是调用这个函数的账户
		//要求候选的Id合法
		require(_candidateId > 0 &&_candidateId <= candidatesCount);
		//确定投票
		voters[msg.sender] = true;
		//更新候选者票数
		candidates[_candidateId].voteCount ++;
        
		emit votedEvent(_candidateId);
	}


}