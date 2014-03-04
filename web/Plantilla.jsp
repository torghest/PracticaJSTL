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
                <font size="6" color="#DD55AA">
                <b>${datosEquipo.nombre_eq}</b>
                </font>
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
                <hr/>
                <font size="4" color="#444444">
                <b>${datosEquipo.nombre_est}</b>
                <table>
                    <tr>
                        <td width="80" align="center">
                            <div style="text-align: center;">
                                <img src="Imagenes/${datosEquipo.foto_estadio}" width="180" height="115"/>
                            </div>
                        </td>
                        <td>
                            <table cellspacing="10">
                                <tr>
                                    <td style="border: 1px solid; background-color: #CCCCCC">
                                        Dirección: ${datosEquipo.direccion}
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid; background-color: #CCCCCC">
                                        Año de Construcción: ${datosEquipo.construccion}
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid; background-color: #CCCCCC">
                                        Aforo: ${datosEquipo.aforo} Aficionados
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                </font>
            </div>
        </div>
    </body>
</html>
