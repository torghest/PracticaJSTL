<%-- 
    Document   : index
    Created on : 04-mar-2014, 12:04:26
    Author     : alumno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql_rt"%>

<sql:setDataSource driver="oracle.jdbc.driver.OracleDriver" 
    url="jdbc:oracle:thin:@localhost:1521:XE"
    user="system" password="javaoracle"/>
<sql:query var="equipos">
    SELECT
        equipo_cod,
        nombre,
        fundacion,
        presidente,
        foto_escudo
    FROM
        equipos
    ORDER BY
        nombre
</sql:query>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div align="center">
            <div style="border: 2px solid; background-color: #EEFF99; display: inline-table; padding: 10px;">
                <font size="6" color="#DD55AA">
                <b>Equipos de Primera Division</b>
                </font>
                <table border="1">
                    <c:set var="i" value="-1"/>
                    <c:forEach items="${equipos.rows}" var="equipo">
                        <c:if test="${i<=0}">
                            <c:if test="${i!=-1}">
                                </tr>
                            </c:if>
                            <tr>
                            <c:set var="i" value="3"/>
                        </c:if>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td bgcolor="#FFFFFF" width="55" align="center" style="border: 1px solid;" onClick="location.href='Plantilla.jsp?equipo_cod=${equipo.equipo_cod}'">
                                        <img src="Imagenes/${equipo.foto_escudo}"/>
                                    </td>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td style="border: 1px solid; background-color: #CCCCCC; padding: 0px 6px;">
                                                    <b>Nombre:</b> ${equipo.nombre}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border: 1px solid; background-color: #CCCCCC; padding: 0px 6px;">
                                                    <b>Año de Fundación:</b> ${equipo.fundacion}
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border: 1px solid; background-color: #CCCCCC; padding: 0px 6px;">
                                                    <b>Presidente:</b> ${equipo.presidente}
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <c:set var="i" value="${i-1}"/>
                    </c:forEach>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>
