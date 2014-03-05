<%-- 
    Document   : calidad
    Created on : 05-mar-2014, 10:51:39
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
        <title>Calidad ${param.equipo}</title>
    </head>
    <body>
        <div align="center">
            <div style="border: 2px solid; display: inline-block; background-color: #CCCCFF; padding: 10px">
                <form name="form" action="calidad.jsp" method="post">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <select name="equipo">
                                    <sql:query var="equipos">
                                        SELECT
                                            equipo_cod,
                                            nombre
                                        FROM
                                            equipos
                                        ORDER BY
                                            nombre
                                    </sql:query>
                                    <c:forEach items="${equipos.rows}" var="e">
                                        <option value="${e.equipo_cod}"${(param.equipo==e.equipo_cod)?" SELECTED":""}>${e.nombre}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td align="center">
                                <select name="tDato">
                                    <option value="calidad"${(param.tDato=='calidad')?" SELECTED":""}>Calidad</option>
                                    <option value="velocidad"${(param.tDato=='velocidad')?" SELECTED":""}>Velocidad</option>
                                    <option value="vision"${(param.tDato=='vision')?" SELECTED":""}>Vision de Juego</option>
                                </select>
                            </td>
                            <td align="right">
                                <input type="submit" value="Ver Datos">
                            </td>
                        </tr>
                    </table>
                </form>
                <hr/>
                <c:if test="${param.equipo!=null}">
                    <table>
                        <sql:query var="tDato">
                            SELECT
                                numero_camiseta,
                                nombre_jugador,
                                ${param.tDato} as tDato
                            FROM
                                jugadores
                            WHERE
                                equipo_cod = ?
                            ORDER BY
                                To_number(numero_camiseta)
                            <sql:param value="${param.equipo}"/>
                        </sql:query>
                        <c:set var="base" value="30"/>
                        <tr>
                            <td>
                                <table border="2">
                                    <tr>
                                        <td align="center" bgcolor="#FFFFFF">
                                            <sql:query var="escudo">
                                                SELECT foto_escudo FROM equipos WHERE equipo_cod = ?
                                                <sql:param value="${param.equipo}"/>
                                            </sql:query>
                                            <div style="text-align: center; background-color: #FFFFFF; width:55px; margin: 0px 20px">
                                                <img src="Imagenes/${escudo.rows[0].foto_escudo}">
                                            </div>
                                        </td>
                                        <td bgcolor="#CCCCCC">
                                            <table border="2">
                                                <tr>
                                                    <td bgcolor="#FF0000" width="${base*10}" height="24">
                                                        <div style="position: absolute; text-align: left; padding: 0px 6px;">0</div>
                                                        <div style="position: relative; right: 0px; text-align: right; padding: 0px 6px;">10</div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <c:forEach items="${tDato.rows}" var="jugador">
                                        <tr>
                                            <td>
                                                ${jugador.numero_camiseta}. ${jugador.nombre_jugador}
                                            </td>
                                            <td  bgcolor="#CCCCCC">
                                                <table border="2">
                                                    <tr>
                                                        <td bgcolor="#FFFF00" width="${base*jugador.tDato}" height="9" align="center">
                                                            <div align="center" style="position: relative;">
                                                                <div style="position: absolute; top: -10px; left: ${base*jugador.tDato/2-2}px">
                                                                    <font size="2">
                                                                    ${jugador.tDato}
                                                                    </font>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </td>
                            <td>

                            </td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </div>
    </body>
</html>
