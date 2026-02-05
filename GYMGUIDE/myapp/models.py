from django.db import models


# Create your models here.
class Login(models.Model):
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    type = models.CharField(max_length=100)

class Trainer(models.Model):
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    phone = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    qualification = models.CharField(max_length=100)
    specialization = models.CharField(max_length=100)
    gender = models.CharField(max_length=100)
    dob = models.DateField()
    photo = models.CharField(max_length=300)
    certificate = models.CharField(max_length=300)
    status = models.CharField(max_length=100)
    experience = models.CharField(max_length=100)

class User(models.Model):
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    phoneno = models.CharField(max_length=100)
    place = models.CharField(max_length=100)
    post = models.CharField(max_length=100)
    pin = models.CharField(max_length=100)
    district = models.CharField(max_length=100)
    photo = models.CharField(max_length=100)
    dob = models.DateField()
    height = models.CharField(max_length=100)
    weight = models.CharField(max_length=100)
    weightmedicaldetails = models.CharField(max_length=100)
    gender = models.CharField(max_length=100)

class Request(models.Model):
    TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    status = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)

class Classes(models.Model):
    classname = models.CharField(max_length=100)
    video = models.CharField(max_length=300)
    description = models.CharField(max_length=100)
    REQUEST = models.ForeignKey(Request, on_delete=models.CASCADE)
    date = models.DateField()
    time=models.TimeField()

class Workoutvideos(models.Model):
    workoutname = models.CharField(max_length=100)
    description = models.CharField(max_length=100)
    level = models.CharField(max_length=100)
    video = models.CharField(max_length=100)
    TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)
    REQUEST = models.ForeignKey(Request, on_delete=models.CASCADE)

class Progress (models.Model):
    USER = models.ForeignKey(User,on_delete=models.CASCADE)
    WORKOUTPLAN = models.ForeignKey(Workoutvideos,on_delete=models.CASCADE)
    date = models.DateField()
    caloriesburned = models.CharField(max_length=100)
    progressnotes = models.CharField(max_length=100)
    weight = models.CharField(max_length=100)

class Assignslot(models.Model):
    TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)
    fromtime = models.TimeField()
    totime = models.TimeField()
    isavailable = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)

class Review(models.Model):
    review = models.CharField(max_length=100)
    rating = models.CharField(max_length=100)
    date = models.DateField()
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)

class Attendance(models.Model):
    date = models.DateField()
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    CLASS = models.ForeignKey(Classes, on_delete=models.CASCADE)
    checkintime = models.TimeField()
    checkouttime = models.TimeField()
    status = models.CharField(max_length=100)

class Facility(models.Model):
    equipment_name = models.CharField(max_length=100)
    quantity = models.CharField(max_length=100)
    maintanance_status = models.CharField(max_length=100)
    photo = models.CharField(max_length=100)

class Tips(models.Model):
    tips = models.CharField(max_length=100)
    description = models.TextField(max_length=100)
    category = models.CharField(max_length=100)
    REQUEST = models.ForeignKey(Request, on_delete=models.CASCADE)


# class Serviceplan(models.Model):
#     Splan = models.CharField(max_length=100)
#     duration = models.CharField(max_length=100,default='')
#     amount = models.CharField(max_length=100,default='')
class Serviceplan(models.Model):
    Splan = models.CharField(max_length=100)
    duration = models.CharField(max_length=100, default='')
    amount = models.CharField(max_length=100, default='')
    free_riding = models.BooleanField(default=True)
    unlimited_equipment = models.BooleanField(default=True)
    personal_trainer = models.BooleanField(default=False)
    weight_loss_classes = models.BooleanField(default=False)
    group_classes = models.BooleanField(default=False)
    swimming_pool_access = models.BooleanField(default=False)
    sauna_access = models.BooleanField(default=False)
    nutrition_plan = models.BooleanField(default=False)

    def __str__(self):
        return self.Splan

class Complaint(models.Model):
    complaint = models.CharField(max_length=100)
    date = models.DateField()
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    reply = models.CharField(max_length=100)
    status = models.CharField(max_length=100, default="")
    # TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)

class Rules(models.Model):
    description = models.CharField(max_length=100)
    TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)

class Chat(models.Model):
    FROMID = models.ForeignKey(Login,on_delete=models.CASCADE,related_name='fid',default='')
    TOID = models.ForeignKey(Login,on_delete=models.CASCADE,related_name='tid',default='')
    message = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)

class Payment(models.Model):
    SERVICEPLAN = models.ForeignKey(Serviceplan, on_delete=models.CASCADE)
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    payment_method = models.CharField(max_length=100)
    amount = models.CharField(max_length=100)
    status = models.CharField(max_length=100)
    date = models.DateField(auto_now_add=True)

class Dietplan(models.Model):
    WORKOUTPLAN = models.ForeignKey(Workoutvideos, on_delete=models.CASCADE)
    Days = models.CharField(max_length=100)
    Session = models.CharField(max_length=100)
    diets = models.CharField(max_length=100)


class Schedule(models.Model):
    date = models.DateField()
    fromtime=models.TimeField()
    totime=models.TimeField()
    TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)
    status = models.CharField(max_length=100)

#
# class Motivationalvideo(models.Model):
#     video = models.CharField(max_length=100)
#     TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)
#     title = models.CharField(max_length=100)
#     description = models.CharField(max_length=100)

#


# class Etiquette(models.Model):
#     Description = models.CharField(max_length=100)


# class Workoutplan(models.Model):
#     TRAINER = models.ForeignKey(Trainer, on_delete=models.CASCADE)
#     plan = models.CharField(max_length=100)
#     REQUEST = models.ForeignKey(Request, on_delete=models.CASCADE)
#     photo = models.CharField(max_length=100)
#     description = models.CharField(max_length=100)


class Health_profle(models.Model):
    USER = models.ForeignKey(User, on_delete=models.CASCADE)
    Height = models.FloatField()
    Weight = models.FloatField()
    Age = models.DateField()
    Obicity=models.CharField(max_length=100)
    Bloodpressure=models.CharField(max_length=100)
    Diabetes=models.CharField(max_length=100)
    Cholestrol=models.CharField(max_length=100)
    Alcoholabuse=models.CharField(max_length=100)
    Druguse=models.CharField(max_length=100)
    Smoking=models.CharField(max_length=100)
    Headaches=models.CharField(max_length=100)
    Asthma=models.CharField(max_length=100)
    Heartproblem=models.CharField(max_length=100)
    Cancer=models.CharField(max_length=100)
    Stroke=models.CharField(max_length=100)
    Bone_joint=models.CharField(max_length=100)
    Kidney=models.CharField(max_length=100)
    Liver=models.CharField(max_length=100)
    Depression=models.CharField(max_length=100)
    Allergies=models.CharField(max_length=100)
    Arthritis=models.CharField(max_length=100)
    Pregnancy=models.CharField(max_length=100)
    bmi=models.FloatField(max_length=100)

class Diet_chart(models.Model):
    Name = models.CharField(max_length=100, default=1)
    Date = models.DateField()
    Time = models.TimeField(max_length=100)
    Dietplan=models.CharField(max_length=500)
    Gender = models.CharField(max_length=100)
    Obicity = models.CharField(max_length=100)
    Bloodpressure = models.CharField(max_length=100)
    Diabetes = models.CharField(max_length=100)
    Cholestrol = models.CharField(max_length=100)
    Alcoholabuse = models.CharField(max_length=100)
    Druguse = models.CharField(max_length=100)
    Smoking = models.CharField(max_length=100)
    Headaches = models.CharField(max_length=100)
    Asthma = models.CharField(max_length=100)
    Heartproblem = models.CharField(max_length=100)
    Cancer = models.CharField(max_length=100)
    Stroke = models.CharField(max_length=100)
    Kidney = models.CharField(max_length=100)
    Liver = models.CharField(max_length=100)
    Depression = models.CharField(max_length=100)
    Allergies = models.CharField(max_length=100)
    Arthritis = models.CharField(max_length=100)
    Pregnancy = models.CharField(max_length=100)
    bmi = models.FloatField(max_length=100)