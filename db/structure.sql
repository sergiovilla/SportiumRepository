CREATE TABLE `colors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `marcas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `pais` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ropas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `modelo` varchar(255) DEFAULT NULL,
  `deporte` varchar(255) DEFAULT NULL,
  `precio` float DEFAULT NULL,
  `nom_equipo` varchar(255) DEFAULT NULL,
  `num_pie` int(11) DEFAULT NULL,
  `marca_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `talla_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ropas_marcas` (`marca_id`),
  KEY `fk_ropas_colors` (`color_id`),
  KEY `fk_ropas_tallas` (`talla_id`),
  CONSTRAINT `fk_ropas_tallas` FOREIGN KEY (`talla_id`) REFERENCES `tallas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ropas_colors` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ropas_marcas` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tallas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_euro` int(11) DEFAULT NULL,
  `nombre_usa` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20140410181219');

INSERT INTO schema_migrations (version) VALUES ('20140411150344');

INSERT INTO schema_migrations (version) VALUES ('20140411154218');

INSERT INTO schema_migrations (version) VALUES ('20140418140006');