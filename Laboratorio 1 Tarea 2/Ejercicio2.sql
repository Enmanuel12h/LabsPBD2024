USE EmployeeManagement
GO

/*
	Ejercicio 2
	Crear una vista que retorne el listado de empleados que han trabajado más horas en departamentos donde el salario promedio 
	está por debajo del salario promedio general de todos los departamentos, debe retornar el id del empleado, el nombre del 
	empleado, el nombre del departamento, la cantidad de horas trabajadas. Debe usar subqueries.
*/

CREATE VIEW EmployeesHighHoursLowSalaryDepartments AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    d.DepartmentName,
    (SELECT SUM(DATEDIFF(HOUR, a.AssignmentDate, GETDATE())) 
     FROM dbo.Assignments a 
     WHERE a.EmployeeID = e.EmployeeID) AS HoursWorked
FROM 
    dbo.Employees e
    INNER JOIN dbo.Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentID IN (
        SELECT d2.DepartmentID
        FROM dbo.Departments d2
        INNER JOIN dbo.Employees e2 ON d2.DepartmentID = e2.DepartmentID
        GROUP BY d2.DepartmentID
        HAVING AVG(e2.Salary) < (
            SELECT AVG(Salary) 
            FROM dbo.Employees
        )
    );

SELECT * 
FROM EmployeesHighHoursLowSalaryDepartments
ORDER BY HoursWorked DESC;


