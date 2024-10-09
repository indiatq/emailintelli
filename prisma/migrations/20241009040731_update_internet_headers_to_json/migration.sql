/*
  Warnings:

  - Added the required column `internetHeaders` to the `Email` table without a default value. This is not possible if the table is not empty.
  - Added the required column `keywords` to the `Email` table without a default value. This is not possible if the table is not empty.
  - Added the required column `omitted` to the `Email` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sysClassifications` to the `Email` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sysLabels` to the `Email` table without a default value. This is not possible if the table is not empty.
  - Added the required column `participantIds` to the `Thread` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Email` ADD COLUMN `internetHeaders` JSON NOT NULL,
    ADD COLUMN `keywords` JSON NOT NULL,
    ADD COLUMN `nativeProperties` JSON NULL,
    ADD COLUMN `omitted` JSON NOT NULL,
    ADD COLUMN `sysClassifications` JSON NOT NULL,
    ADD COLUMN `sysLabels` JSON NOT NULL;

-- AlterTable
ALTER TABLE `Thread` ADD COLUMN `participantIds` JSON NOT NULL;
