import 'package:flutter/material.dart';
import 'package:ti_asistan/Providers/iObjectProvider.dart';
import 'package:ti_asistan/service/apiService.dart';
import 'package:ti_asistan/sreens/taches_screen.dart';

class Tacheprovider with ChangeNotifier implements Iobjectprovider<Tache> {
    @override
  late Apiservice api = Apiservice();
  @override
  List<Tache> objets = [
    Tache(
      nom: "Acheter du pain",
      description: "Aller à la boulangerie avant la fermeture",
      priorite: Priorite.normale,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Rendre le projet Flutter",
      description: "Envoyer le lien du dépôt Git au professeur",
      priorite: Priorite.urgent,
      statut: Statut.Encours,
    ),
    Tache(
      nom: "Appeler maman",
      description: "Prendre des nouvelles pour son anniversaire",
      priorite: Priorite.haute,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Réparer l'évier",
      description: "Le robinet fuit depuis hier soir",
      priorite: Priorite.haute,
      statut: Statut.Encours,
    ),
    Tache(
      nom: "Sport",
      description: "Séance de 45 minutes de cardio",
      priorite: Priorite.basse,
      statut: Statut.Complete,
    ),
    Tache(
      nom: "Réserver restaurant",
      description: "Pour la sortie d'équipe vendredi soir",
      priorite: Priorite.normale,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Mise à jour Windows",
      description: "Installer les derniers correctifs de sécurité",
      priorite: Priorite.basse,
      statut: Statut.Annule,
    ),
    Tache(
      nom: "Préparer réunion",
      description: "Faire les slides pour la présentation de lundi",
      priorite: Priorite.haute,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Payer loyer",
      description: "Virement automatique à vérifier",
      priorite: Priorite.urgent,
      statut: Statut.Complete,
    ),
    Tache(
      nom: "Nettoyer voiture",
      description: "Passer l'aspirateur et laver l'extérieur",
      priorite: Priorite.basse,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "RDV Dentiste",
      description: "Contrôle annuel à 14h30",
      priorite: Priorite.normale,
      statut: Statut.Encours,
    ),
    Tache(
      nom: "Lire chapitre 5",
      description: "Livre sur l'architecture logicielle",
      priorite: Priorite.basse,
      statut: Statut.Encours,
    ),
    Tache(
      nom: "Arroser les plantes",
      description: "Ne pas oublier les orchidées",
      priorite: Priorite.basse,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Debug SignalR",
      description: "Le hub se déconnecte de façon aléatoire",
      priorite: Priorite.urgent,
      statut: Statut.Encours,
    ),
    Tache(
      nom: "Sortir les poubelles",
      description: "Passage du camion demain matin",
      priorite: Priorite.normale,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Apprendre les Enums",
      description: "Réviser le mapping JSON vers Enum en Dart",
      priorite: Priorite.haute,
      statut: Statut.Complete,
    ),
    Tache(
      nom: "Courses hebdo",
      description: "Liste sur le frigo",
      priorite: Priorite.normale,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Refaire CV",
      description: "Ajouter l'expérience Flutter et Ti Asistan",
      priorite: Priorite.haute,
      statut: Statut.AFaire,
    ),
    Tache(
      nom: "Méditation",
      description: "10 minutes de calme avant de dormir",
      priorite: Priorite.basse,
      statut: Statut.Complete,
    ),
    Tache(
      nom: "Changer mot de passe",
      description: "Sécuriser le compte bancaire",
      priorite: Priorite.urgent,
      statut: Statut.AFaire,
    ),
  ];
    @override
  
  bool isLoading = false;
  Apiservice apiservice = Apiservice();
  List<Tache> get taches => objets.toList();

  @override
  void charger(List<Tache> objets) {
     isLoading = true;
    notifyListeners();
    taches.sort((t, tac) {
      int priorite = tac.priorite.index.compareTo(t.priorite.index);
      if (priorite != 0) {
        return priorite;
      }
      return tac.statut.index.compareTo(t.statut.index);
    });
    objets = taches;
    isLoading = false;
    notifyListeners();
  }

  @override
  void initialiser() async {
    charger(await apiservice.recevoirTaches());

  }


}
