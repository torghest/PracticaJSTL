<%-- 
    Document   : index
    Created on : 05-mar-2014, 8:20:24
    Author     : alumno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql_rt"%>

<sql:setDataSource driver="oracle.jdbc.driver.OracleDriver" 
    url="jdbc:oracle:thin:@localhost:1521:XE"
    user="system" password="javaoracle"/>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Datos Equipos</title>
    </head>
    <body>
        <table align="center">
            <tr>
                <td valign="top">
                    <table cellspacing="20">
                        <form name="form" action="EstJug.jsp" method="post">
                        <tr>
                            <td align="center">
                                <input type="submit" value="Ver Datos"/>
                                <input type="reset" value="Borrar" onclick="location.href='index.jsp'"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="border: 1px solid;">
                                <div style="background-color: #FFFF99; padding: 10px;">
                                    <input type="radio" name="tDato" value="Estadios"${(param.tDato=='Estadios')?" CHECKED":""}/>
                                    Estadios
                                    <br/>
                                    <input type="radio" name="tDato" value="Jugadores"${(param.tDato=='Jugadores')?" CHECKED":""}/>
                                    Jugadores
                                </div> 
                            </td>
                        </tr>
                        <tr>
                            <td style="border: 1px solid;">
                                <div style="background-color: #FFCC99; padding: 10px;">
                                    <sql:query var="equipos">
                                        SELECT
                                            equipo_cod,
                                            nombre
                                        FROM
                                            equipos
                                        ORDER BY
                                            nombre
                                    </sql:query>
                                    <c:forEach items="${equipos.rows}" var="equipo">
                                        <c:forEach items="${paramValues.equipos}" var="sel">
                                            <c:if test="${sel == equipo.equipo_cod}">
                                                <c:set var="chkSel" value=" CHECKED"/>
                                            </c:if>
                                        </c:forEach>
                                        <input type="checkbox" name="equipos" value="${equipo.equipo_cod}"${(chkSel!=null)?chkSel:""}/>
                                        <c:remove var="chkSel"/>
                                        ${equipo.nombre}
                                        <br/>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                        </form>
                    </table>
                </td>
                <c:if test="${param.tDato != null}">
                    <c:set var="tDato" value="${param.tDato}"/>
                    <td align="center" valign="top">
                        <h2>Datos de los ${tDato}</h2>
                        <c:if test="${tDato == 'Estadios'}">
                            <c:set var="camposSql">
                                nombre,
                                direccion,
                                construccion,
                                aforo
                            </c:set>
                        </c:if>
                        <c:if test="${tDato == 'Jugadores'}">
                            <c:set var="camposSql">
                                nombre,
                                apellidos,
                                numero_camiseta as NUMERO,
                                calidad,
                                velocidad,
                                vision,
                                nombre_jugador as APODO
                            </c:set>
                        </c:if>
                        <c:set var="checked">
                            <c:forEach items="${paramValues.equipos}" var="equipos" varStatus="i">
                                <c:if test="${!i.first}">
                                    ,
                                </c:if>
                                ${equipos}
                            </c:forEach>
                        </c:set>
                        <sql:query var="datos">
                            SELECT
                                ${camposSql}
                            FROM
                                ${tDato}
                            WHERE
                                equipo_cod in (${checked})
                            ORDER BY
                                equipo_cod
                        </sql:query>
<%--                        <sql:query var="datos" sql="${QuerySql}"/> --%>
                        <table border="2" bgcolor="#CCCCFF">
                            <tr>
                                <c:forEach items="${datos.columnNames}" var="cabeceras">
                                    <td align="center" style="background-color: #333333; color: #DDDDDD; padding: 0px 5px;">
                                        <b>${cabeceras}</b>
                                    </td>
                                </c:forEach>
                            </tr>
                            <c:forEach items="${datos.rowsByIndex}" var="fila">
                                <tr>
                                    <c:forEach items="${fila}" var="dato">
                                        <td style="padding: 0px 5px;">
                                            ${dato}
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </c:if>
            </tr>
        </table>
    </body>
</html>
