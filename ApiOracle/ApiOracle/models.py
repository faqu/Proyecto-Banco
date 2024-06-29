from django.db import models
from django.contrib.auth.hashers import make_password, check_password


class Roles(models.Model):
    idroles = models.AutoField(primary_key=True)
    nombre_rol = models.CharField(max_length=100)
    fecha_de_registro = models.DateField(auto_now_add=True)

    def __str__(self):
        return self.nombre_rol


class Login(models.Model):
    idlogin = models.AutoField(primary_key=True, db_column="idlogin")
    correo = models.CharField(max_length=255)
    contrasena = models.CharField(max_length=128)
    fecha_registro = models.DateField(auto_now_add=True)
    fk_roles = models.ForeignKey(Roles, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.correo} - {self.idlogin}"

    def set_password(self, raw_password):
    # Hash the password using Django's make_password only if it's not already hashed
        if not raw_password.startswith(('pbkdf2_sha256$', 'bcrypt', 'argon2')):
            self.contrasena = make_password(raw_password)
        else:
            self.contrasena = raw_password


    def check_password(self, raw_password):
        # Check the password using Django's check_password
        return check_password(raw_password, self.contrasena)

    @property
    def id(self):
        return self.idlogin
