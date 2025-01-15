const chai = require('chai');
const chaiHttp = require('chai-http');
const sinon = require('sinon');
const { expect } = chai;
const app = require('../server'); // Cambia el path según tu estructura
const mysql = require('mysql2');

chai.use(chaiHttp);

describe('API Tests', () => {
  let poolStub;

  before(() => {
    // Mock de la conexión a la base de datos
    poolStub = sinon.stub(mysql, 'createPool').returns({
      query: (query, params, callback) => {
        if (query.includes('INSERT INTO contactos')) {
          callback(null, { insertId: 1 });
        } else {
          callback(new Error('Query no soportada'));
        }
      },
    });
  });

  after(() => {
    sinon.restore();
  });

  it('Debe insertar un contacto correctamente', (done) => {
    chai.request(app)
      .post('/api/contact')
      .send({ name: 'Test User', email: 'test@example.com', message: 'Hello!' })
      .end((err, res) => {
        expect(res).to.have.status(201);
        expect(res.body).to.include({
          id: 1,
          nombre: 'Test User',
          email: 'test@example.com',
          mensaje: 'Hello!',
        });
        done();
      });
  });

  it('Debe devolver un error si faltan datos obligatorios', (done) => {
    chai.request(app)
      .post('/api/contact')
      .send({ name: '', email: '', message: '' })
      .end((err, res) => {
        expect(res).to.have.status(500);
        expect(res.body).to.have.property('error').that.includes('Error al guardar los datos.');
        done();
      });
  });

  it('Debe redirigir después de procesar', (done) => {
    chai.request(app)
      .post('/api/contact')
      .send({ name: 'Test User', email: 'test@example.com', message: 'Hello!' })
      .end((err, res) => {
        expect(res).to.redirectTo('/');
        done();
      });
  });
});
