const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  await prisma.temperatureReading.deleteMany();
  await prisma.humidityReading.deleteMany();
  await prisma.windSpeedReading.deleteMany();
  await prisma.sensor.deleteMany(); // Clear existing sensors and readings

  // Creating sensors
  const createdSensors = await prisma.$transaction([
    prisma.sensor.create({ data: { type: 'TEMPERATURE', location: 'New York', unit: '°C' } }),
    prisma.sensor.create({ data: { type: 'HUMIDITY', location: 'Los Angeles', unit: '%' } }),
    prisma.sensor.create({ data: { type: 'WIND_SPEED', location: 'Chicago', unit: 'm/s' } }),
  ]);

  // Extract sensor IDs
  const tempSensor = createdSensors.find(s => s.type === 'TEMPERATURE');
  const humiditySensor = createdSensors.find(s => s.type === 'HUMIDITY');
  const windSensor = createdSensors.find(s => s.type === 'WIND_SPEED');

  // Generate random readings
  function generateReadings(sensorId, min, max) {
    return Array.from({ length: 100 }, (_, i) => ({
      sensorId,
      value: parseFloat((Math.random() * (max - min) + min).toFixed(2)),
      timestamp: new Date(Date.now() - i * 3600 * 1000),
    }));
  }

  // Add readings
  await prisma.$transaction([
    prisma.temperatureReading.createMany({ data: generateReadings(tempSensor.id, 15, 35) }),
    prisma.humidityReading.createMany({ data: generateReadings(humiditySensor.id, 30, 70) }),
    prisma.windSpeedReading.createMany({ data: generateReadings(windSensor.id, 1, 10) }),
  ]);

  console.log('Seeding completed!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
