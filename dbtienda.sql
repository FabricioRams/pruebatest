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


-- Volcando estructura de base de datos para dbtienda
CREATE DATABASE IF NOT EXISTS `dbtienda` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */;
USE `dbtienda`;

-- Volcando estructura para tabla dbtienda.carrito
CREATE TABLE IF NOT EXISTS `carrito` (
  `idCarrito` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precioUnitario` decimal(10,2) NOT NULL,
  `fechaAgregado` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idCarrito`),
  KEY `idCliente` (`idCliente`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `tbcliente` (`idcliente`),
  CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tbproducto` (`idproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.carrito: ~0 rows (aproximadamente)

-- Volcando estructura para tabla dbtienda.tbcargo
CREATE TABLE IF NOT EXISTS `tbcargo` (
  `idcargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`idcargo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbcargo: ~3 rows (aproximadamente)
INSERT INTO `tbcargo` (`idcargo`, `nombre`) VALUES
	(1, 'Administrador'),
	(2, 'Vendedor'),
	(3, 'Cliente');

-- Volcando estructura para tabla dbtienda.tbcliente
CREATE TABLE IF NOT EXISTS `tbcliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `dni` varchar(8) NOT NULL,
  `email` varchar(100) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `idcargo` int(11) NOT NULL,
  `idestado` int(11) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `email` (`email`),
  KEY `idcargo` (`idcargo`),
  KEY `idestado` (`idestado`),
  CONSTRAINT `tbcliente_ibfk_1` FOREIGN KEY (`idcargo`) REFERENCES `tbcargo` (`idcargo`),
  CONSTRAINT `tbcliente_ibfk_2` FOREIGN KEY (`idestado`) REFERENCES `tbestado` (`idestado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbcliente: ~2 rows (aproximadamente)
INSERT INTO `tbcliente` (`idcliente`, `dni`, `email`, `clave`, `nombres`, `apellidos`, `telefono`, `direccion`, `idcargo`, `idestado`, `fecha_registro`) VALUES
	(1, '12345678', 'admin@tienda.com', '123456', 'Admin', 'Sistema', '952328888', '', 1, 1, '2025-10-09 22:52:44'),
	(4, '12345679', 'cliente1@gmail.com', '123123', 'Cleinte', 'Cliente', '952328888', '12313213', 3, 1, '2025-10-14 16:49:39');

-- Volcando estructura para tabla dbtienda.tbcolor
CREATE TABLE IF NOT EXISTS `tbcolor` (
  `idcolor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `codigo_hex` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`idcolor`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbcolor: ~8 rows (aproximadamente)
INSERT INTO `tbcolor` (`idcolor`, `nombre`, `codigo_hex`) VALUES
	(1, 'Negro', '#000000'),
	(2, 'Blanco', '#FFFFFF'),
	(3, 'Rojo', '#FF0000'),
	(4, 'Azul Marino', '#000080'),
	(5, 'Verde Oliva', '#808000'),
	(6, 'Gris', '#808080'),
	(7, 'Azul', '#0000FF'),
	(8, 'Verde', '#008000');

-- Volcando estructura para tabla dbtienda.tbestado
CREATE TABLE IF NOT EXISTS `tbestado` (
  `idestado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbestado: ~3 rows (aproximadamente)
INSERT INTO `tbestado` (`idestado`, `nombre`) VALUES
	(1, 'Activo'),
	(2, 'Inactivo'),
	(3, 'Suspendido');

-- Volcando estructura para tabla dbtienda.tbmarca
CREATE TABLE IF NOT EXISTS `tbmarca` (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`idmarca`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbmarca: ~5 rows (aproximadamente)
INSERT INTO `tbmarca` (`idmarca`, `nombre`, `descripcion`) VALUES
	(1, 'Nike', 'Marca deportiva internacional'),
	(2, 'Adidas', 'Marca deportiva alemana'),
	(3, 'Zara', 'Marca de moda espa?ola'),
	(4, 'Puma', 'Marca deportiva alemana'),
	(5, 'H&M', 'Marca de moda sueca');

-- Volcando estructura para tabla dbtienda.tbmodelo
CREATE TABLE IF NOT EXISTS `tbmodelo` (
  `idmodelo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `idmarca` int(11) NOT NULL,
  PRIMARY KEY (`idmodelo`),
  KEY `idmarca` (`idmarca`),
  CONSTRAINT `tbmodelo_ibfk_1` FOREIGN KEY (`idmarca`) REFERENCES `tbmarca` (`idmarca`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbmodelo: ~8 rows (aproximadamente)
INSERT INTO `tbmodelo` (`idmodelo`, `nombre`, `descripcion`, `idmarca`) VALUES
	(1, 'Air Force 1', 'Zapatillas deportivas cl?sicas', 1),
	(2, 'Dri-FIT Legend', 'Camiseta de entrenamiento', 1),
	(3, 'Ultraboost', 'Zapatillas running', 2),
	(4, 'Tiro 21', 'Pantalones de entrenamiento', 2),
	(5, 'Pantal?n Tapered', 'Pantal?n de vestir ajustado', 3),
	(6, 'Blusa Basic', 'Blusa b?sica femenina', 3),
	(7, 'RS-X', 'Zapatillas urbanas', 4),
	(8, 'Training Top', 'Top de entrenamiento', 4);

-- Volcando estructura para tabla dbtienda.tbproducto
CREATE TABLE IF NOT EXISTS `tbproducto` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `idmodelo` int(11) NOT NULL,
  `idcolor` int(11) NOT NULL,
  `idtalla` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`idproducto`),
  KEY `idmodelo` (`idmodelo`),
  KEY `idcolor` (`idcolor`),
  KEY `idtalla` (`idtalla`),
  CONSTRAINT `tbproducto_ibfk_1` FOREIGN KEY (`idmodelo`) REFERENCES `tbmodelo` (`idmodelo`),
  CONSTRAINT `tbproducto_ibfk_2` FOREIGN KEY (`idcolor`) REFERENCES `tbcolor` (`idcolor`),
  CONSTRAINT `tbproducto_ibfk_3` FOREIGN KEY (`idtalla`) REFERENCES `tbtalla` (`idtalla`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbproducto: ~5 rows (aproximadamente)
INSERT INTO `tbproducto` (`idproducto`, `nombre`, `descripcion`, `precio`, `stock`, `idmodelo`, `idcolor`, `idtalla`, `imagen`, `fecha_creacion`, `activo`) VALUES
	(1, 'Zapatillas Nike Air Force 1 Blancas', 'Zapatillas deportivas cl?sicas de cuero blanco', 299.90, 22, 1, 2, 3, NULL, '2025-10-09 23:09:20', 1),
	(2, 'Camiseta Nike Dri-FIT Legend', 'Camiseta de entrenamiento con tecnolog?a Dri-FIT', 89.90, 50, 2, 1, 2, NULL, '2025-10-09 23:09:20', 1),
	(3, 'Zapatillas Adidas Ultraboost', 'Zapatillas running con tecnolog?a Boost', 399.90, 10, 3, 4, 3, NULL, '2025-10-09 23:09:20', 1),
	(4, 'Pantal?n Zara Tapered Negro', 'Pantal?n de vestir ajustado color negro', 129.90, 30, 5, 1, 7, NULL, '2025-10-09 23:09:20', 1),
	(5, 'Blusa Zara Basic Blanca', 'Blusa b?sica femenina color blanco', 79.90, 40, 6, 2, 1, NULL, '2025-10-09 23:09:20', 1);

-- Volcando estructura para tabla dbtienda.tbtalla
CREATE TABLE IF NOT EXISTS `tbtalla` (
  `idtalla` int(11) NOT NULL AUTO_INCREMENT,
  `valor` varchar(10) NOT NULL,
  `idtipotalla` int(11) NOT NULL,
  PRIMARY KEY (`idtalla`),
  KEY `idtipotalla` (`idtipotalla`),
  CONSTRAINT `tbtalla_ibfk_1` FOREIGN KEY (`idtipotalla`) REFERENCES `tbtipotalla` (`idtipotalla`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbtalla: ~15 rows (aproximadamente)
INSERT INTO `tbtalla` (`idtalla`, `valor`, `idtipotalla`) VALUES
	(1, 'S', 1),
	(2, 'M', 1),
	(3, 'L', 1),
	(4, 'XL', 1),
	(5, 'XXL', 1),
	(6, '28', 2),
	(7, '30', 2),
	(8, '32', 2),
	(9, '34', 2),
	(10, '36', 2),
	(11, '6', 3),
	(12, '7', 3),
	(13, '8', 3),
	(14, '9', 3),
	(15, '10', 3);

-- Volcando estructura para tabla dbtienda.tbtipotalla
CREATE TABLE IF NOT EXISTS `tbtipotalla` (
  `idtipotalla` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idtipotalla`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

-- Volcando datos para la tabla dbtienda.tbtipotalla: ~3 rows (aproximadamente)
INSERT INTO `tbtipotalla` (`idtipotalla`, `nombre`, `descripcion`) VALUES
	(1, 'INTERNACIONAL', 'Tallas S, M, L, XL'),
	(2, 'NUMERICA_USA', 'Tallas num?ricas 28, 30, 32'),
	(3, 'CALZADO_USA', 'Tallas de calzado 6, 7, 8, 9');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
