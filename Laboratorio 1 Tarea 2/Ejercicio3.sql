USE EmployeeManagement
GO

/*
	Ejercicio 3
	Crear una vista que retorne el listado de departamentos donde los proyectos asignados tienen la duración más larga además 
	debe retornar la duración promedio de los proyectos para los departamentos. La salida debe mostrar el id del departamento, 
	el nombre del departamento, la duración del proyecto y el promedio del proyecto.
*/

CREATE VIEW DepartmentLongestProjects AS
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    DATEDIFF(DAY, p.StartDate, p.EndDate) AS ProjectDuration,
    (SELECT AVG(DATEDIFF(DAY, p2.StartDate, p2.EndDate))
     FROM dbo.Projects p2
     INNER JOIN dbo.Assignments a2 ON p2.ProjectID = a2.ProjectID
     INNER JOIN dbo.Employees e2 ON a2.EmployeeID = e2.EmployeeID
     WHERE e2.DepartmentID = d.DepartmentID) AS AvgProjectDuration
FROM 
    dbo.Departments d
    INNER JOIN dbo.Employees e ON d.DepartmentID = e.DepartmentID
    INNER JOIN dbo.Assignments a ON e.EmployeeID = a.EmployeeID
    INNER JOIN dbo.Projects p ON a.ProjectID = p.ProjectID
WHERE 
    DATEDIFF(DAY, p.StartDate, p.EndDate) = (
        SELECT MAX(DATEDIFF(DAY, p3.StartDate, p3.EndDate))
        FROM dbo.Projects p3
        INNER JOIN dbo.Assignments a3 ON p3.ProjectID = a3.ProjectID
        INNER JOIN dbo.Employees e3 ON a3.EmployeeID = e3.EmployeeID
        WHERE e3.DepartmentID = d.DepartmentID
    );

SELECT * FROM DepartmentLongestProjects