// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "hardhat/console.sol";

contract Aadhar1 {
    uint256 public nextUserId = 1;
    uint256 public nextOperatorId = 1;

    struct Appointment {
        string date;
        string time;
        string status;
        string appointmentType;
        uint256 userId;
        uint256 operatorId;
    }

    struct User {
        uint256 id;
        string name;
        string email;
        string password;
        string role;
    }

    struct Operator {
        uint256 id;
        string name;
        string email;
        string password;
        string latitude;
        string longitude;
        string role;
    }

    // mapping to store user details
    mapping(uint256 => User) public users;

    // mapping to store operator details
    mapping(uint256 => Operator) public operators;

    // mapping to store appointment details
    mapping(uint256 => Appointment) public appointments;

    // function to register user and check whether the user already exists 
    function registerUser(string memory _name, string memory _email, string memory _password, string memory _role) public {
        bool userExists = false;
        for (uint256 i = 1; i < nextUserId; i++) {
            if (keccak256(bytes(users[i].email)) == keccak256(bytes(_email))) {
                userExists = true;
                break;
            }
        }
        if (!userExists) {
            users[nextUserId] = User(nextUserId, _name, _email, _password, _role);
            nextUserId++;
        }
    }

    // function to register operator and check whether the operator already exists
    function registerOperator(string memory _name, string memory _email, string memory _password, string memory _latitude, string memory _longitude, string memory _role) public {
        bool operatorExists = false;
        for (uint256 i = 1; i < nextOperatorId; i++) {
            if (keccak256(bytes(operators[i].email)) == keccak256(bytes(_email))) {
                operatorExists = true;
                break;
            }
        }
        if (!operatorExists) {
            operators[nextOperatorId] = Operator(nextOperatorId, _name, _email, _password, _latitude, _longitude, _role);
            nextOperatorId++;
        }
    }

    // function to login user
    function loginUser(string memory _email, string memory _password) public view returns (uint256) {
        for (uint256 i = 1; i < nextUserId; i++) {
            if (keccak256(bytes(users[i].email)) == keccak256(bytes(_email)) && keccak256(bytes(users[i].password)) == keccak256(bytes(_password))) {
                return users[i].id;
            }
        }
        return 0;
    }

    // function to login operator
    function loginOperator(string memory _email, string memory _password) public view returns (uint256) {
        for (uint256 i = 1; i < nextOperatorId; i++) {
            if (keccak256(bytes(operators[i].email)) == keccak256(bytes(_email)) && keccak256(bytes(operators[i].password)) == keccak256(bytes(_password))) {
                return operators[i].id;
            }
        }
        return 0;
    }

    // function to get all operators
    function getAllOperators() public view returns (Operator[] memory) {
        Operator[] memory _operators = new Operator[](nextOperatorId - 1);
        for (uint256 i = 1; i < nextOperatorId; i++) {
            _operators[i - 1] = operators[i];
        }
        return _operators;
    }

    // function to add appointment in both user and operator mappings based on the user address and operator id
    function addAppointment(string memory _date, string memory _time, string memory _status, string memory _appointmentType, uint256 _userId, uint256 _operatorId) public {
        appointments[_userId] = Appointment(_date, _time, _status, _appointmentType, _userId, _operatorId);
        appointments[_operatorId] = Appointment(_date, _time, _status, _appointmentType, _userId, _operatorId);
    }

    // function to get user appointment details based on the user address and userId and returns the date, time, status and appointment type and the operator details by fetching the operator details based on the operatorId appointment struct have
    function getUserAppointment(uint256 _userId) public view returns (string memory, string memory, string memory, string memory, Operator memory) {
        Appointment memory appointment = appointments[_userId];
        Operator memory operator = operators[appointment.operatorId];
        return (appointment.date, appointment.time, appointment.status, appointment.appointmentType, operator);
    }

    // function to update the appointment status and update status in both user and operator appointment mappings
    function updateAppointmentStatus(string memory _status, uint256 _userId, uint256 _operatorId) public {
        appointments[_userId].status = _status;
        appointments[_operatorId].status = _status;
    }

    // function to get all appointments of a operator by operatorid
    function getAllAppointments(uint256 _operatorId) public view returns (Appointment[] memory) {
        Appointment[] memory _appointments = new Appointment[](nextUserId - 1);
        uint256 j = 0;
        for (uint256 i = 1; i < nextUserId; i++) {
            if (appointments[i].operatorId == _operatorId) {
                _appointments[j] = appointments[i];
                j++;
            }
        }
        return _appointments;
    }
    
}