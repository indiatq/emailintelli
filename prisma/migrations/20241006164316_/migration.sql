-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `emailAddress` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NULL,
    `imageUrl` VARCHAR(191) NULL,
    `stripeSubscriptionId` VARCHAR(191) NULL,
    `role` ENUM('user', 'admin') NOT NULL DEFAULT 'user',

    UNIQUE INDEX `User_emailAddress_key`(`emailAddress`),
    UNIQUE INDEX `User_stripeSubscriptionId_key`(`stripeSubscriptionId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ChatbotInteraction` (
    `id` VARCHAR(191) NOT NULL,
    `day` VARCHAR(191) NOT NULL,
    `count` INTEGER NOT NULL DEFAULT 1,
    `userId` VARCHAR(191) NULL,

    UNIQUE INDEX `ChatbotInteraction_userId_key`(`userId`),
    INDEX `ChatbotInteraction_day_userId_idx`(`day`, `userId`),
    UNIQUE INDEX `ChatbotInteraction_day_userId_key`(`day`, `userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StripeSubscription` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `userId` VARCHAR(191) NULL,
    `subscriptionId` VARCHAR(191) NULL,
    `productId` VARCHAR(191) NULL,
    `priceId` VARCHAR(191) NULL,
    `customerId` VARCHAR(191) NULL,
    `currentPeriodEnd` DATETIME(3) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `StripeSubscription_userId_key`(`userId`),
    UNIQUE INDEX `StripeSubscription_subscriptionId_key`(`subscriptionId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Account` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `binaryIndex` JSON NULL,
    `token` VARCHAR(191) NOT NULL,
    `provider` VARCHAR(191) NOT NULL,
    `emailAddress` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `nextDeltaToken` VARCHAR(191) NULL,

    UNIQUE INDEX `Account_token_key`(`token`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Thread` (
    `id` VARCHAR(191) NOT NULL,
    `subject` VARCHAR(191) NOT NULL,
    `lastMessageDate` DATETIME(3) NOT NULL,
    `accountId` VARCHAR(191) NOT NULL,
    `done` BOOLEAN NOT NULL DEFAULT false,
    `inboxStatus` BOOLEAN NOT NULL DEFAULT true,
    `draftStatus` BOOLEAN NOT NULL DEFAULT false,
    `sentStatus` BOOLEAN NOT NULL DEFAULT false,

    INDEX `Thread_accountId_idx`(`accountId`),
    INDEX `Thread_done_idx`(`done`),
    INDEX `Thread_inboxStatus_idx`(`inboxStatus`),
    INDEX `Thread_draftStatus_idx`(`draftStatus`),
    INDEX `Thread_sentStatus_idx`(`sentStatus`),
    INDEX `Thread_lastMessageDate_idx`(`lastMessageDate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Email` (
    `id` VARCHAR(191) NOT NULL,
    `threadId` VARCHAR(191) NOT NULL,
    `createdTime` DATETIME(3) NOT NULL,
    `lastModifiedTime` DATETIME(3) NOT NULL,
    `sentAt` DATETIME(3) NOT NULL,
    `receivedAt` DATETIME(3) NOT NULL,
    `internetMessageId` VARCHAR(191) NOT NULL,
    `subject` VARCHAR(191) NOT NULL,
    `sensitivity` ENUM('normal', 'private', 'personal', 'confidential') NOT NULL DEFAULT 'normal',
    `meetingMessageMethod` ENUM('request', 'reply', 'cancel', 'counter', 'other') NULL,
    `fromId` VARCHAR(191) NOT NULL,
    `hasAttachments` BOOLEAN NOT NULL,
    `body` VARCHAR(191) NULL,
    `bodySnippet` VARCHAR(191) NULL,
    `inReplyTo` VARCHAR(191) NULL,
    `references` VARCHAR(191) NULL,
    `threadIndex` VARCHAR(191) NULL,
    `folderId` VARCHAR(191) NULL,
    `emailLabel` ENUM('inbox', 'sent', 'draft') NOT NULL DEFAULT 'inbox',

    INDEX `Email_threadId_idx`(`threadId`),
    INDEX `Email_emailLabel_idx`(`emailLabel`),
    INDEX `Email_sentAt_idx`(`sentAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EmailAddress` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `address` VARCHAR(191) NOT NULL,
    `raw` VARCHAR(191) NULL,
    `accountId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `EmailAddress_accountId_address_key`(`accountId`, `address`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EmailAttachment` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `mimeType` VARCHAR(191) NOT NULL,
    `size` INTEGER NOT NULL,
    `inline` BOOLEAN NOT NULL,
    `contentId` VARCHAR(191) NULL,
    `content` VARCHAR(191) NULL,
    `contentLocation` VARCHAR(191) NULL,
    `emailId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ToEmails` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ToEmails_AB_unique`(`A`, `B`),
    INDEX `_ToEmails_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_CcEmails` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_CcEmails_AB_unique`(`A`, `B`),
    INDEX `_CcEmails_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_BccEmails` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_BccEmails_AB_unique`(`A`, `B`),
    INDEX `_BccEmails_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ReplyToEmails` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ReplyToEmails_AB_unique`(`A`, `B`),
    INDEX `_ReplyToEmails_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_stripeSubscriptionId_fkey` FOREIGN KEY (`stripeSubscriptionId`) REFERENCES `StripeSubscription`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChatbotInteraction` ADD CONSTRAINT `ChatbotInteraction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Account` ADD CONSTRAINT `Account_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Thread` ADD CONSTRAINT `Thread_accountId_fkey` FOREIGN KEY (`accountId`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Email` ADD CONSTRAINT `Email_threadId_fkey` FOREIGN KEY (`threadId`) REFERENCES `Thread`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Email` ADD CONSTRAINT `Email_fromId_fkey` FOREIGN KEY (`fromId`) REFERENCES `EmailAddress`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EmailAddress` ADD CONSTRAINT `EmailAddress_accountId_fkey` FOREIGN KEY (`accountId`) REFERENCES `Account`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EmailAttachment` ADD CONSTRAINT `EmailAttachment_emailId_fkey` FOREIGN KEY (`emailId`) REFERENCES `Email`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ToEmails` ADD CONSTRAINT `_ToEmails_A_fkey` FOREIGN KEY (`A`) REFERENCES `Email`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ToEmails` ADD CONSTRAINT `_ToEmails_B_fkey` FOREIGN KEY (`B`) REFERENCES `EmailAddress`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CcEmails` ADD CONSTRAINT `_CcEmails_A_fkey` FOREIGN KEY (`A`) REFERENCES `Email`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CcEmails` ADD CONSTRAINT `_CcEmails_B_fkey` FOREIGN KEY (`B`) REFERENCES `EmailAddress`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BccEmails` ADD CONSTRAINT `_BccEmails_A_fkey` FOREIGN KEY (`A`) REFERENCES `Email`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BccEmails` ADD CONSTRAINT `_BccEmails_B_fkey` FOREIGN KEY (`B`) REFERENCES `EmailAddress`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ReplyToEmails` ADD CONSTRAINT `_ReplyToEmails_A_fkey` FOREIGN KEY (`A`) REFERENCES `Email`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ReplyToEmails` ADD CONSTRAINT `_ReplyToEmails_B_fkey` FOREIGN KEY (`B`) REFERENCES `EmailAddress`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
