USE EmployeeManagement
GO

/*
	Ejercicio 1
	Crear una vista que retorne cada uno de los departamentos y retorne los empleados que tienen el mayor salario por departamento 
	según el proyecto asignado. En otras palabras, debe retornar los empleados dentro de cada departamento que tienen el salario más 
	alto entre todos los empleados asignados a cualquier proyecto en ese departamento. Debe retornar el Id del departamento, el nombre 
	del departamento, el id del empleado, el nombre del empleado y el salario del empleado. Debe usar subqueries.
*/

CREATE VIEW DepartmentTopEarners AS
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    e.Salary
FROM 
    dbo.Departments d
    INNER JOIN dbo.Employees e ON d.DepartmentID = e.DepartmentID
WHERE 
    e.Salary = (
        SELECT MAX(e2.Salary)
        FROM dbo.Employees e2
        INNER JOIN dbo.Assignments a ON e2.EmployeeID = a.EmployeeID
        WHERE e2.DepartmentID = d.DepartmentID
    );


select * from DepartmentTopEarners