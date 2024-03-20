// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract TaskContract {
    uint nextId;
    
    struct Task { //struct: permite crear un tipo de dato personalizado, en este caso para cada tarea
        uint id;
        string name;
        string description;
    }

    Task[] tasks; //tasks es de tipo de dato "Task[]" que creamos con "struct"

    function CreateTask(string memory _name, string memory _description) public { //Función pública para crear una tarea y sumarle +1 al índice
        tasks.push(Task(nextId, _name, _description));
        nextId++; //id+=1
    }

    //Función que le pasamos entero positivo(_id), es de uso interno(solo existe para que la usen otras funciones), "view" porque no cambiamos ningún dato, por último indicamos qué tipo de dato retorna
    function FindIndex(uint _id) internal view returns(uint) {
        for(uint i = 0; i < tasks.length; i++) {
            if(tasks[i].id == _id) {
                return i;
            }
        }
        revert("Task not found"); //revert: permite lanzar un error en caso de que no se cumpla cierta condición, en este caso, si no se encuentra el id
    }

    function ReadTask(uint _id) public view returns(uint, string memory, string memory) { //"memory" solo va a estar guardado el string un tiempo, en el tiempo de ejecución, no se va a guardar en la blockchain
        uint index = FindIndex(_id);
        return (tasks[index].id, tasks[index].name, tasks[index].description);
    }

    function UpdateTask(uint _id, string memory _name, string memory _description) public {
        uint index = FindIndex(_id);
        tasks[index].name = _name;
        tasks[index].description = _description;
    }

    function DeleteTask(uint _id) public {
        uint index = FindIndex(_id);
        delete tasks[index];
    }
}