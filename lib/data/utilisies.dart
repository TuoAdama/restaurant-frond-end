import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/plat.dart';

class Utilisies {
  static String  host = "http://10.0.3.2:8000/";

  static List<Category> categories = [
    Category.formJson({
        "id": 1,
        "libelle": "viande",
        "avatar": "images/categories/viande.jpg",
        "created_at": "2021-08-10T12:23:44.000000Z",
        "updated_at": "2021-08-10T12:23:44.000000Z"
    }),

    Category.formJson({
            "id": 2,
            "libelle": "poisson",
            "avatar": "images/categories/poisson.jpg",
            "created_at": "2021-08-10T14:04:31.000000Z",
            "updated_at": "2021-08-10T14:04:31.000000Z"
    }),

    Category.formJson({
            "id": 3,
            "libelle": "lait",
            "avatar": "images/categories/lait.jpg",
            "created_at": "2021-08-10T14:04:31.000000Z",
            "updated_at": "2021-08-10T14:04:31.000000Z"
    }),

    Category.formJson({
            "id": 4,
            "libelle": "fruit",
            "avatar": "images/categories/fruit.jpg",
            "created_at": "2021-08-10T14:04:31.000000Z",
            "updated_at": "2021-08-10T14:04:31.000000Z"
    }),
    Category.formJson({
            "id": 5,
            "libelle": "fruit",
            "avatar": "images/categories/fruit.jpg",
            "created_at": "2021-08-10T14:04:31.000000Z",
            "updated_at": "2021-08-10T14:04:31.000000Z"
    }),

    Category.formJson({
            "id": 5,
            "libelle": "fruit",
            "avatar": "images/categories/fruit.jpg",
            "created_at": "2021-08-10T14:04:31.000000Z",
            "updated_at": "2021-08-10T14:04:31.000000Z"
    }),

  ];


  static List<Plat> plats = [
    Plat.fromJson({
            "id": 1,
            "categorie_id": 1,
            "libelle": "coca-cola",
            "prix": 500,
            "created_at": "2021-08-10T13:14:21.000000Z",
            "updated_at": "2021-09-04T22:44:06.000000Z",
            "images": [
                {
                    "id": 3,
                    "plat_id": 1,
                    "chemin": "plats/1/5.jpg",
                    "created_at": "2021-09-06T00:21:22.000000Z",
                    "updated_at": "2021-09-06T00:21:22.000000Z"
                },
                {
                    "id": 4,
                    "plat_id": 1,
                    "chemin": "plats/1/0.jpg",
                    "created_at": "2021-09-06T00:22:39.000000Z",
                    "updated_at": "2021-09-06T00:22:39.000000Z"
                }
            ],
            "categorie": {
                "id": 1,
                "libelle": "viande",
                "avatar": "images/categories/viande.jpg",
                "created_at": "2021-08-10T12:23:44.000000Z",
                "updated_at": "2021-08-10T12:23:44.000000Z"
            }
        }),

    Plat.fromJson({
            "id": 1,
            "categorie_id": 2,
            "libelle": "poisson braisé",
            "prix": 800,
            "created_at": "2021-09-04T22:05:05.000000Z",
            "updated_at": "2021-09-04T22:44:41.000000Z",
            "images": [
                {
                    "id": 5,
                    "plat_id": 3,
                    "chemin": "plats/3/0.jpg",
                    "created_at": "2021-09-06T00:39:48.000000Z",
                    "updated_at": "2021-09-06T00:39:48.000000Z"
                }
            ],
            "categorie": {
                "id": 2,
                "libelle": "poisson",
                "avatar": "images/categories/poisson.jpg",
                "created_at": "2021-08-10T14:04:31.000000Z",
                "updated_at": "2021-08-10T14:04:31.000000Z"
            }
        }),

    Plat.fromJson({
            "id": 2,
            "categorie_id": 2,
            "libelle": "poisson grillé",
            "prix": 800,
            "created_at": "2021-09-04T22:05:05.000000Z",
            "updated_at": "2021-09-04T22:44:41.000000Z",
            "images": [
                {
                    "id": 5,
                    "plat_id": 3,
                    "chemin": "plats/3/0.jpg",
                    "created_at": "2021-09-06T00:39:48.000000Z",
                    "updated_at": "2021-09-06T00:39:48.000000Z"
                }
            ],
            "categorie": {
                "id": 2,
                "libelle": "poisson",
                "avatar": "images/categories/poisson.jpg",
                "created_at": "2021-08-10T14:04:31.000000Z",
                "updated_at": "2021-08-10T14:04:31.000000Z"
            }
        }),
    Plat.fromJson({
            "id": 3,
            "categorie_id": 2,
            "libelle": "viande hachée",
            "prix": 800,
            "created_at": "2021-09-04T22:05:05.000000Z",
            "updated_at": "2021-09-04T22:44:41.000000Z",
            "images": [
                {
                    "id": 5,
                    "plat_id": 3,
                    "chemin": "plats/3/0.jpg",
                    "created_at": "2021-09-06T00:39:48.000000Z",
                    "updated_at": "2021-09-06T00:39:48.000000Z"
                }
            ],
            "categorie": {
                "id": 2,
                "libelle": "poisson",
                "avatar": "images/categories/poisson.jpg",
                "created_at": "2021-08-10T14:04:31.000000Z",
                "updated_at": "2021-08-10T14:04:31.000000Z"
            }
        }),
        Plat.fromJson({
            "id": 4,
            "categorie_id": 2,
            "libelle": "viande hachée",
            "prix": 800,
            "created_at": "2021-09-04T22:05:05.000000Z",
            "updated_at": "2021-09-04T22:44:41.000000Z",
            "images": [
                {
                    "id": 5,
                    "plat_id": 3,
                    "chemin": "plats/3/0.jpg",
                    "created_at": "2021-09-06T00:39:48.000000Z",
                    "updated_at": "2021-09-06T00:39:48.000000Z"
                }
            ],
            "categorie": {
                "id": 2,
                "libelle": "poisson",
                "avatar": "images/categories/poisson.jpg",
                "created_at": "2021-08-10T14:04:31.000000Z",
                "updated_at": "2021-08-10T14:04:31.000000Z"
            }
        }),

        Plat.fromJson({
            "id": 5,
            "categorie_id": 2,
            "libelle": "viande hachée",
            "prix": 800,
            "created_at": "2021-09-04T22:05:05.000000Z",
            "updated_at": "2021-09-04T22:44:41.000000Z",
            "images": [
                {
                    "id": 5,
                    "plat_id": 3,
                    "chemin": "plats/3/0.jpg",
                    "created_at": "2021-09-06T00:39:48.000000Z",
                    "updated_at": "2021-09-06T00:39:48.000000Z"
                }
            ],
            "categorie": {
                "id": 2,
                "libelle": "poisson",
                "avatar": "images/categories/poisson.jpg",
                "created_at": "2021-08-10T14:04:31.000000Z",
                "updated_at": "2021-08-10T14:04:31.000000Z"
            }
        }),

        Plat.fromJson({
            "id": 6,
            "categorie_id": 2,
            "libelle": "viande hachée",
            "prix": 800,
            "created_at": "2021-09-04T22:05:05.000000Z",
            "updated_at": "2021-09-04T22:44:41.000000Z",
            "images": [
                {
                    "id": 5,
                    "plat_id": 3,
                    "chemin": "plats/3/0.jpg",
                    "created_at": "2021-09-06T00:39:48.000000Z",
                    "updated_at": "2021-09-06T00:39:48.000000Z"
                }
            ],
            "categorie": {
                "id": 2,
                "libelle": "poisson",
                "avatar": "images/categories/poisson.jpg",
                "created_at": "2021-08-10T14:04:31.000000Z",
                "updated_at": "2021-08-10T14:04:31.000000Z"
            }
        })
  ];

}