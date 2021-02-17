const supertest = require('supertest');
const app = require('../app');
const User = require("../userSchema");
const path = require("path");

const deleteUser = async (mail) => {
    await User.deleteOne({ "info.mail": mail });
};

var fs = require('fs');

describe("Inscription", () => {

    it("Creation d'un utilisateur", async () => {
        const response = await supertest(app).post('/users/register').send({
            mail: "units@epitech.eu",
            lastName: "toto",
            firstName: "tata",
            age: 39,
            gender: "H",
            password: "bonsoir"
        });
        expect(response.status).toBe(201);
    });

    it("Creation d'un utilisateur déjà existant", async () => {
        const response = await supertest(app).post('/users/register').send({
            mail: "units@epitech.eu",
            lastName: "toto",
            firstName: "tata",
            age: 39,
            gender: "H",
            password: "bonsoir"
        });
        expect(response.status).toBe(400);
    });

    it("Email non renseigné", async () => {

        const response = await supertest(app).post('/users/register').send({
            mail: "",
            lastName: "toto",
            firstName: "tata",
            age: 39,
            gender: "H",
            password: "bonsoir"
        });

        expect(response.status).toBe(401);
    });

    it("Mot de passe non renseigné", async () => {

        const response = await supertest(app).post('/users/register').send({
            mail: "false@epitech.eu",
            lastName: "toto",
            firstName: "tata",
            age: 39,
            gender: "H",
            password: ""
        });

        expect(response.status).toBe(401);
    });

    it("Nom non renseigné", async () => {

        const response = await supertest(app).post('/users/register').send({
            mail: "false@epitech.eu",
            lastName: "",
            firstName: "tata",
            age: 39,
            gender: "H",
            password: "bonsoir"
        });

        expect(response.status).toBe(401);
    });

    it("Prénom non renseigné", async () => {

        const response = await supertest(app).post('/users/register').send({
            mail: "tests@epitech.eu",
            lastName: "toto",
            firstName: "",
            age: 39,
            gender: "H",
            password: "bonsoir"
        });

        expect(response.status).toBe(401);
    });
});

describe("Connexion", () => {

    it("Connexion avec un bon mot de passe", async () => {

        const response = await supertest(app).post('/users/login').send({
            mail: "units@epitech.eu",
            password: "bonsoir"
        });

        expect(response.status).toBe(200);
    });

    it("Connexion avec un mauvais mot de passe", async () => {

        const response = await supertest(app).post('/users/login').send({
            mail: "units@epitech.eu",
            password: "toto"
        });

        expect(response.status).toBe(400);
    });

    it("Connexion avec mauvais un email", async () => {

        const response = await supertest(app).post('/users/login').send({
            mail: "false@epitech.eu",
            password: "toto"
        });

        expect(response.status).toBe(404);
    });
})

describe("Reinitialisation de mot de passe", async () => {

    // it("Réinitialisation avec un bon mail", async () => {

    //     const response = await supertest(app).post('/users/auth/forget').send({
    //         mail: "units@epitech.eu",
    //     });

    //     expect(response.status).toBe(200);
    // });

    it("Réinitialisation avec un mauvais mail", async () => {

        const response = await supertest(app).post('/users/auth/forget').send({
            mail: "false@epitech.eu",
        });

        expect(response.status).toBe(404);
        deleteUser("units@epitech.eu");
    });
})

describe("Recherche de poissons", () => {

    it("Recherche d'un poisson clown", async () => {
        // Récuperer le fichier clown2.jpg et le convertir en base64
        var clowndata = fs.readFileSync(path.join(__dirname, "clown2.jpg"), 'base64');

        const response = await supertest(app).post('/find/').send({
            imageData: clowndata
        });
        expect(response.body.data).toBe('Poisson clown');
    });

    it("Recherche d'un idole des maures", async () => {
        // Récuperer le fichier idole1.jpg et le convertir en base64
        var idoledata = fs.readFileSync(path.join(__dirname, "idole1.jpg"), "base64");

        const response = await supertest(app).post('/find/').send({
            imageData: idoledata
        });
        expect(response.body.data).toBe('Idole des maures');
    });
})

describe("Jeu", () => {

    it("Monter de niveau", async () => {
        // Tester si l'utilisateur level up

        const response = await supertest(app).put('/game/level/').send({
            id: "5f8715267f10b342f182290a",
            exp: 1000,
        });
        expect(response.body.message).toBe('level up successful');
    });

    it("Monter de niveau avec une autre valeur", async () => {
        // Tester si l'utilisateur level up

        const response = await supertest(app).put('/game/level/').send({
            id: "5f8715267f10b342f182290a",
            exp: 2000,
        });
        expect(response.body.message).toBe('level up successful');
    });
})
