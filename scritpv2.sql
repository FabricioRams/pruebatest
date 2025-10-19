-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mvc_tienda
CREATE DATABASE IF NOT EXISTS `mvc_tienda` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `mvc_tienda`;

-- Volcando estructura para tabla mvc_tienda.tbcargo
CREATE TABLE IF NOT EXISTS `tbcargo` (
  `idcargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcargo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla mvc_tienda.tbcargo: ~4 rows (aproximadamente)
INSERT INTO `tbcargo` (`idcargo`, `nombre`, `estado`) VALUES
	(1, 'Administrador', 1),
	(2, 'Gerente', 1),
	(3, 'Vendedor', 1),
	(4, 'Cliente', 1);

-- Volcando estructura para tabla mvc_tienda.tbcliente
CREATE TABLE IF NOT EXISTS `tbcliente` (
  `dni` varchar(8) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `clave` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla mvc_tienda.tbcliente: ~2 rows (aproximadamente)
INSERT INTO `tbcliente` (`dni`, `nombres`, `apellidos`, `direccion`, `email`, `clave`, `estado`, `fecha_registro`) VALUES
	('12345678', 'Pedro', 'Sánchez', 'Av. Principal 123', 'pedro@email.com', '123456', 1, '2025-10-19 17:37:26'),
	('87654321', 'Lucía', 'Fernández', 'Calle Secundaria 456', 'lucia@email.com', '123456', 1, '2025-10-19 17:37:26');

-- Volcando estructura para tabla mvc_tienda.tbusuario
CREATE TABLE IF NOT EXISTS `tbusuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `idcargo` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `fk_cargo` (`idcargo`),
  CONSTRAINT `fk_cargo` FOREIGN KEY (`idcargo`) REFERENCES `tbcargo` (`idcargo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla mvc_tienda.tbusuario: ~4 rows (aproximadamente)
INSERT INTO `tbusuario` (`idusuario`, `usuario`, `clave`, `nombre`, `apellido`, `email`, `idcargo`, `estado`, `fecha_registro`) VALUES
	(1, 'admin', '123456', 'Juan', 'Pérez', 'admin@tienda.com', 1, 1, '2025-10-19 17:37:26'),
	(2, 'gerente1', '123456', 'María', 'García', 'gerente@tienda.com', 2, 1, '2025-10-19 17:37:26'),
	(3, 'vendedor1', '123456', 'Carlos', 'López', 'vendedor@tienda.com', 3, 1, '2025-10-19 17:37:26'),
	(4, 'vendedor2', '123456', 'Ana', 'Martínez', 'ana@tienda.com', 3, 1, '2025-10-19 17:37:26');

-- Volcando estructura para vista mvc_tienda.vw_usuarios
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vw_usuarios` (
	`idusuario` INT(11) NOT NULL,
	`usuario` VARCHAR(1) NOT NULL COLLATE 'latin1_swedish_ci',
	`nombre` VARCHAR(1) NOT NULL COLLATE 'latin1_swedish_ci',
	`apellido` VARCHAR(1) NOT NULL COLLATE 'latin1_swedish_ci',
	`email` VARCHAR(1) NULL COLLATE 'latin1_swedish_ci',
	`idcargo` INT(11) NOT NULL,
	`cargo_nombre` VARCHAR(1) NOT NULL COLLATE 'latin1_swedish_ci',
	`estado` INT(11) NOT NULL,
	`fecha_registro` DATETIME NULL
);

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vw_usuarios`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_usuarios` AS SELECT 
    u.idusuario,
    u.usuario,
    u.nombre,
    u.apellido,
    u.email,
    u.idcargo,
    c.nombre as cargo_nombre,
    u.estado,
    u.fecha_registro
FROM tbusuario u
INNER JOIN tbcargo c ON u.idcargo = c.idcargo 
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
