# Generated by Django 4.1 on 2024-06-10 12:07

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("student", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="student2course",
            name="score",
            field=models.FloatField(blank=True, null=True, verbose_name="成绩"),
        ),
    ]
