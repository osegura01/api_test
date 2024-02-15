CREATE TABLE `persona` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido1` varchar(255) DEFAULT NULL,
  `apellido2` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_persona` int NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `correo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_persona`)
        REFERENCES persona(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `persona`
  (`nombre`, `apellido1`, `apellido2`, `fecha_nacimiento`, `genero`)
VALUES
  ('Juan', 'Gutierrez', '', '1990-01-01', 'M'),
  ('Miguel', 'López', '', '2000-02-29', 'M'),
  ('Bárbara', 'Pérez', '', '1995-03-31', 'F'),
  ('Renata', 'Martínez', '', '2005-04-30', 'F');

INSERT INTO `usuario`
  (`id_persona`, `usuario`, `password`, `correo`)
VALUES
 (1, 'jgutierrez', '2574f251fb8c183b038e19b29ae5b829', 'jgutierrez@mail.com'),
 (2, 'mlopez', '2574f251fb8c183b038e19b29ae5b829', 'mlopez@mail.com'),
 (3, 'bperez', '2574f251fb8c183b038e19b29ae5b829', 'bperez@mail.com'),
 (4, 'rmartinez', '2574f251fb8c183b038e19b29ae5b829', 'rmartinez@mail.com');
