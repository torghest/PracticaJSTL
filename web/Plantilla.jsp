<%-- 
    Document   : Plantilla
    Created on : 04-mar-2014, 13:07:31
    Author     : alumno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql_rt"%>

<sql:setDataSource driver="oracle.jdbc.driver.OracleDriver" 
    url="jdbc:oracle:thin:@localhost:1521:XE"
    user="system" password="javaoracle"/>
<sql:query var="equipo">
    SELECT
        eq.nombre nombre_eq,
        eq.foto_equipo,
        eq.foto_escudo,
        es.nombre nombre_est,
        es.direccion,
        es.construccion,
        es.aforo,
        es.foto_estadio
    FROM
        equipos eq
        join
        estadios es
            on eq.equipo_cod = es.equipo_cod
    WHERE
        eq.equipo_cod = ?
    <sql:param value="${param.equipo_cod}"/>
</sql:query>
<c:set var="datosEquipo" value="${equipo.rows[0]}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${datosEquipo.nombre_eq}</title>
    </head>
    <body>
        <div align="center">
            <div style="border: 2px solid; background-color: #EEFF99; display: inline-table; padding: 10px;">
                <table>
                    <tr>
                        <td align="center">
                            <div style="border: 2px solid; text-align: center; background-color: #FFFFFF; width:55px; margin: 0px 20px">
                                <img src="Imagenes/${datosEquipo.foto_escudo}"/>
                            </div>
                        </td>
                        <td align="center">
                            <font size="6" color="#DD55AA">
                            <b>${datosEquipo.nombre_eq}</b>
                            </font>
                        </td>
                    </tr>
                </table>
                <!--
                <hr/>
                <table>
                    <tr>
                        <td width="80" align="center">
                            <div style="border: 2px solid; text-align: center; background-color: #FFFFFF; width:55px;">
                                <img src="Imagenes/${datosEquipo.foto_escudo}"/>
                            </div>
                        </td>
                        <td>
                            <div style="text-align: center;">
                                <img src="Imagenes/${datosEquipo.foto_equipo}" width="180" height="115"/>
                            </div>
                        </td>
                    </tr>
                </table>
                -->
                <hr/>
                <font size="4" color="#444444">
                <b>Estadio:</b> ${datosEquipo.nombre_est}
                </font>
                <table width="100%">
                    <tr>
                        <td width="80" align="center">
                            <div style="text-align: center;">
                                <img src="Imagenes/${datosEquipo.foto_estadio}" width="180" height="115"/>
                            </div>
                        </td>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td style="border: 1px solid; background-color: #CCCCCC; padding: 8px 20px 8px 20px;">
                                        <b>Dirección:</b> ${datosEquipo.direccion}
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid; background-color: #CCCCCC; padding: 8px 20px 8px 20px;">
                                        <b>Año de Construcción:</b> ${datosEquipo.construccion}
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid; background-color: #CCCCCC; padding: 8px 20px 8px 20px;">
                                        <b>Aforo:</b> ${datosEquipo.aforo} Aficionados
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <hr/>
                <font size="4" color="#444444">
                <b>Plantilla</b>
                </font>
                <table>
                    <tr>
                        <td align="center" valign="top">
                            <div style="text-align: center;">
                                <img src="Imagenes/${datosEquipo.foto_equipo}" width="180" height="115"/>
                            </div>
                            <table width="100%">
                                <c:set var="portero" value="#FFAA55"/>
                                <c:set var="defensa" value="#8888FF"/>
                                <c:set var="medio" value="#88FF88"/>
                                <c:set var="delantero" value="#FF8888"/>
                                <tr>
                                    <td width="50%" align="center" style="border: 1px solid; background-color: ${portero}">
                                        Portero
                                    </td>
                                    <td width="50%" align="center" style="border: 1px solid; background-color: ${defensa}">
                                        Defensa
                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%" align="center" style="border: 1px solid; background-color: ${medio}">
                                        Medio
                                    </td>
                                    <td width="50%" align="center" style="border: 1px solid; background-color: ${delantero}">
                                        Delantero
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <sql:query var="jugadores">
                                SELECT
                                    jug.nombre_jugador,
                                    jug.numero_camiseta,
                                    pos.demarcacion
                                FROM
                                    jugadores jug
                                    join
                                    posicion pos
                                        on jug.demarcacion = pos.cod_demarc
                                WHERE
                                    jug.equipo_cod = ?
                                ORDER BY
                                    demarcacion
                                <sql:param value="${param.equipo_cod}"/>
                            </sql:query>
                            <table>
                                <c:set var="i" value="-1"/>
                                <c:forEach items="${jugadores.rows}" var="jugador">
                                    <c:if test="${i<=0}">
                                        <c:if test="${i!=-1}">
                                            </tr>
                                        </c:if>
                                        <tr>
                                        <c:set var="i" value="2"/>
                                    </c:if>
                                    <c:set var="demarcacion" value="${jugador.demarcacion}"/>
                                    <c:choose>
                                        <c:when test="${demarcacion=='DEFENSA'}"><c:set var="color" value="${defensa}"/></c:when>
                                        <c:when test="${demarcacion=='MEDIO'}"><c:set var="color" value="${medio}"/></c:when>
                                        <c:when test="${demarcacion=='DELANTERO'}"><c:set var="color" value="${delantero}"/></c:when>
                                        <c:when test="${demarcacion=='PORTERO'}"><c:set var="color" value="${portero}"/></c:when>
                                        <c:otherwise><c:set var="color" value="#FFFFFF"/></c:otherwise>
                                    </c:choose>

                                    <td style="border: 1px solid; background-color: ${color}">
                                        ${jugador.nombre_jugador}(${jugador.numero_camiseta})
                                    </td>
                                    <c:set var="i" value="${i-1}"/>
                                </c:forEach>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </body>
</html>
