-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 18 août 2023 à 14:23
-- Version du serveur : 10.5.19-MariaDB-0+deb11u2
-- Version de PHP : 8.1.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `s1_fgezfze`
--

-- --------------------------------------------------------

--
-- Structure de la table `MCoffre`
--

CREATE TABLE `MCoffre` (
  `id` int(255) NOT NULL,
  `capacite` int(255) NOT NULL,
  `job` varchar(255) NOT NULL DEFAULT 'false',
  `jobautoriser` varchar(255) DEFAULT NULL,
  `gang` varchar(255) NOT NULL DEFAULT 'false',
  `gangautoriser` varchar(255) DEFAULT NULL,
  `public` varchar(255) NOT NULL DEFAULT 'false',
  `x` varchar(255) NOT NULL,
  `y` varchar(255) NOT NULL,
  `z` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `MCoffre`
--

INSERT INTO `MCoffre` (`id`, `capacite`, `job`, `jobautoriser`, `gang`, `gangautoriser`, `public`, `x`, `y`, `z`) VALUES
(11, 20000, 'false', NULL, 'false', NULL, 'true', '338.9311828613281', '106.8658676147461', '101.94943237304688'),
(12, 20000, 'true', 'ambulance', 'false', NULL, 'false', '343.9126281738281', '109.48461151123047', '102.3747787475586');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `MCoffre`
--
ALTER TABLE `MCoffre`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `MCoffre`
--
ALTER TABLE `MCoffre`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
